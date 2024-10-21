import 'package:mobx/mobx.dart';
import 'package:otaku_movie_app/api/service.dart';
import 'package:otaku_movie_app/models/model.dart';
import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

part 'mobx_store.g.dart';

// ignore: library_private_types_in_public_api
class MovieStore = _MovieStore with _$MovieStore;

abstract class _MovieStore with Store {
  final APIservice _apiService = APIservice();

  late final Future<Database> database;

  _MovieStore() {
    database = initDatabase();
  }

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = p.join(databasePath, 'doggie_database.db');

    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await _createBookmarkTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < newVersion) {
          await db.execute('DROP TABLE IF EXISTS bookmarks');
          await _createBookmarkTable(db);
        }
      },
    );
  }

  Future<void> _createBookmarkTable(Database db) async {
    await db.execute(
      'CREATE TABLE bookmarks('
      'id INTEGER PRIMARY KEY, '
      'title TEXT, '
      'backDropPath TEXT, '
      'voteAverage REAL, '
      'overview TEXT, '
      'poster_path TEXT, '
      'genreIds TEXT, '
      'releaseDate TEXT, '
      'runtime INTEGER, '
      'originalLanguage TEXT, '
      'rating TEXT, '
      'popularity REAL'
      ')',
    );
  }

  @action
  Future<void> loadBookmarkedMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('bookmarks');
    bookmarkedMovies = ObservableList<Movie>.of(maps.map((map) => Movie.fromMap(map)).toList());
  }

  Future<void> saveBookmark(Movie movie) async {
    final db = await database;
    await db.insert(
      'bookmarks',
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeBookmark(Movie movie) async {
    final db = await database;
    await db.delete(
      'bookmarks',
      where: 'title = ?',
      whereArgs: [
        movie.title
      ],
    );
  }

  @observable
  bool isDarkMode = false;

  @observable
  String title = '';

  @observable
  String selectedLanguage = 'en';

  @observable
  ObservableStream<List<Movie>>? searchResult;

  @observable
  ObservableList<Movie> bookmarkedMovies = ObservableList<Movie>();

  @action
  void toggleTheme() {
    isDarkMode = !isDarkMode;
  }

  @action
  void changeLanguage(String language) {
    selectedLanguage = language;
  }

  @action
  bool isBookmarked(Movie movie) {
    return bookmarkedMovies.any((m) => m.title == movie.title);
  }

  @action
  Future<void> toggleBookmark(Movie movie) async {
    final db = await database;
    if (isBookmarked(movie)) {
      bookmarkedMovies.removeWhere((m) => m.title == movie.title);
      await db.delete(
        'bookmarks',
        where: 'title = ?',
        whereArgs: [
          movie.title
        ],
      );
    } else {
      bookmarkedMovies.add(movie);
      await db.insert(
        'bookmarks',
        movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    print('Bookmarked Movies: ${bookmarkedMovies.length}');
    bookmarkedMovies = ObservableList<Movie>.of(bookmarkedMovies);
  }

  @observable
  ObservableStream<List<Movie>>? nowShowingMovies;

  @action
  void listenToNowShowingMovies() {
    nowShowingMovies = ObservableStream(_apiService.nowShowingMoviesStream);
    _apiService.getNowShowingMovies();
  }

  @observable
  ObservableStream<List<Movie>>? popularMovies;

  @action
  void listenToPopularMovies() {
    popularMovies = ObservableStream(_apiService.popularMoviesStream);
    _apiService.getPopularMovies();
  }

  @observable
  ObservableStream<List<Movie>>? upcomingMovies;

  @action
  void listenToUpcomingMovies() {
    upcomingMovies = ObservableStream(_apiService.upcomingMoviesStream);
    _apiService.getUpcomingMovies();
  }

  @action
  void searchMovies(String query) {
    _apiService.searchMovies(query);
    searchResult = ObservableStream(_apiService.searchMoviesStream);
  }

  Future<void> dispose() async {
    _apiService.dispose();
    final db = await database;
    await db.close();
  }
}
