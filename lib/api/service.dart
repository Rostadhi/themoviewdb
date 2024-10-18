import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:otaku_movie_app/models/model.dart';

const apiKey = "589b8a5511310b4abb4382fe9d23b31c";

class APIservice {
  // Define BehaviorSubjects for each API response stream
  final _nowShowingMoviesSubject = BehaviorSubject<List<Movie>>();
  final _popularMoviesSubject = BehaviorSubject<List<Movie>>();
  final _upcomingMoviesSubject = BehaviorSubject<List<Movie>>();
  final _movieDetailSubject = BehaviorSubject<Movie>();
  final _searchMoviesSubject = BehaviorSubject<List<Movie>>();

  // Public streams to listen to the emitted values
  Stream<List<Movie>> get nowShowingMoviesStream => _nowShowingMoviesSubject.stream;
  Stream<List<Movie>> get popularMoviesStream => _popularMoviesSubject.stream;
  Stream<List<Movie>> get upcomingMoviesStream => _upcomingMoviesSubject.stream;
  Stream<Movie> get movieDetailStream => _movieDetailSubject.stream;
  Stream<List<Movie>> get searchMoviesStream => _searchMoviesSubject.stream;

  // Discover Now Showing Animation/Anime Movies (Released after a certain date)
  final nowShowingApi = "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=16&primary_release_date.gte=2023-01-01";

  // Discover Popular Animation/Anime Movies
  final popularApi = "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=16&sort_by=popularity.desc";

  // Upcoming Movie
  final upcomingMovieApi = "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=16&primary_release_date.gte=2024-10-01&sort_by=release_date.asc";

  String getMovieDetailApi(int movieId) {
    return "https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey";
  }

  // Search Movie
  Uri getSearchMovieApi(String query) {
    return Uri.parse("https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query&with_genres=16");
  }

  // Fetch 'Now Showing' Animation Movies
  Future<List<Movie>> getNowShowing() async {
    Uri url = Uri.parse(nowShowingApi);
    final response = await http.get(url);

    /// you can add another status code for debugging
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data: ${response.body}");
    }
  }

  // Fetch Popular Animation Movies
  Future<List<Movie>> getPopular() async {
    Uri url = Uri.parse(popularApi);
    final response = await http.get(url);

    /// you can add another status code for debugging
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data: ${response.body}");
    }
  }

  // Fetch Detailed Movie Info by Movie ID
  Future<Movie> getMovieDetail(int movieId) async {
    Uri url = Uri.parse(getMovieDetailApi(movieId));
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Movie.fromMap(data); // Convert JSON to Movie model
    } else {
      throw Exception("Failed to load movie details: ${response.body}");
    }
  }

  // Search Movies by Query
  Future<void> searchMovies(String query) async {
    Uri url = getSearchMovieApi(query);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['results'];
        List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();

        // Filter out movies that don't contain the 'Animation' genre (ID: 16)
        List<Movie> filteredMovies = movies.where((movie) {
          return movie.genreIds?.contains(16) ?? false; // Ensure it has genre ID 16 (Animation)
        }).toList();

        _searchMoviesSubject.add(filteredMovies); // Add filtered movies to the BehaviorSubject
      } else {
        _searchMoviesSubject.addError("Failed to load search results: ${response.body}");
      }
    } catch (e) {
      _searchMoviesSubject.addError("Error fetching search results: $e");
    }
  }

  // func to try rxdart
  // Fetch 'Now Showing' Animation Movies and emit to the stream
  Future<void> getNowShowingRX() async {
    Uri url = Uri.parse(nowShowingApi);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['results'];
        List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
        _nowShowingMoviesSubject.add(movies); // Add the data to the BehaviorSubject
      } else {
        _nowShowingMoviesSubject.addError("Failed to load data: ${response.body}");
      }
    } catch (e) {
      _nowShowingMoviesSubject.addError("Error fetching now showing movies: $e");
    }
  }

  // Fetch Popular Animation Movies and emit to the stream
  Future<void> getPopularRX() async {
    Uri url = Uri.parse(popularApi);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['results'];
        List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
        _popularMoviesSubject.add(movies); // Add the data to the BehaviorSubject
      } else {
        _popularMoviesSubject.addError("Failed to load data: ${response.body}");
      }
    } catch (e) {
      _popularMoviesSubject.addError("Error fetching popular movies: $e");
    }
  }

  // Fetch Upcoming Movies and emit to the stream
  Future<void> getUpcomingRX() async {
    Uri url = Uri.parse(upcomingMovieApi);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['results'];
        List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
        _upcomingMoviesSubject.add(movies); // Add the data to the BehaviorSubject
      } else {
        _upcomingMoviesSubject.addError("Failed to load data: ${response.body}");
      }
    } catch (e) {
      _upcomingMoviesSubject.addError("Error fetching upcoming movies: $e");
    }
  }

  // Fetch Detailed Movie Info by Movie ID and emit to the stream
  Future<void> getMovieDetailRX(int movieId) async {
    Uri url = Uri.parse(getMovieDetailApi(movieId));
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        Movie movie = Movie.fromMap(data);
        _movieDetailSubject.add(movie); // Add the movie details to the BehaviorSubject
      } else {
        _movieDetailSubject.addError("Failed to load movie details: ${response.body}");
      }
    } catch (e) {
      _movieDetailSubject.addError("Error fetching movie details: $e");
    }
  }

  // Search Movies by Query and emit to the stream
  Future<void> searchMoviesRX(String query) async {
    Uri url = getSearchMovieApi(query);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['results'];
        List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();

        // Filter out movies that don't contain the 'Animation' genre (ID: 16)
        List<Movie> filteredMovies = movies.where((movie) {
          return movie.genreIds?.contains(16) ?? false; // Ensure it has genre ID 16 (Animation)
        }).toList();

        _searchMoviesSubject.add(filteredMovies); // Add filtered movies to the BehaviorSubject
      } else {
        _searchMoviesSubject.addError("Failed to load search results: ${response.body}");
      }
    } catch (e) {
      _searchMoviesSubject.addError("Error fetching search results: $e");
    }
  }

  // Dispose of the BehaviorSubjects to avoid memory leaks
  void dispose() {
    _nowShowingMoviesSubject.close();
    _popularMoviesSubject.close();
    _upcomingMoviesSubject.close();
    _movieDetailSubject.close();
    _searchMoviesSubject.close();
  }
}
