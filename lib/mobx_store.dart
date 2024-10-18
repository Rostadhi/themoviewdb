import 'package:mobx/mobx.dart';
import 'package:otaku_movie_app/api/service.dart';
import 'package:otaku_movie_app/models/model.dart';

part 'mobx_store.g.dart';

// ignore: library_private_types_in_public_api
class MovieStore = _MovieStore with _$MovieStore;

abstract class _MovieStore with Store {
  final APIservice _apiService = APIservice();

  // Dark mode state
  @observable
  bool isDarkMode = false;

  // App title
  @observable
  String title = '';

  // Localization state
  @observable
  String selectedLanguage = 'en';

  // Now Showing movies
  @observable
  ObservableFuture<List<Movie>>? nowShowingMovies;

  // Popular movies
  @observable
  ObservableFuture<List<Movie>>? popularMovies;

  // Upcoming movies
  @observable
  ObservableFuture<List<Movie>>? upComingMovies;

  // Search results using RxDart stream
  @observable
  ObservableStream<List<Movie>>? searchResultRx;

  // Bookmarked movies as an observable list
  @observable
  ObservableList<Movie> bookmarkedMoviesRx = ObservableList<Movie>();

  // Action to toggle the dark mode
  @action
  void toggleTheme() {
    isDarkMode = !isDarkMode;
  }

  // Action to change the language
  @action
  void changeLanguage(String language) {
    selectedLanguage = language;
  }

  // Check if a movie is bookmarked
  @action
  bool isBookmarkedRx(Movie movie) {
    return bookmarkedMoviesRx.contains(movie);
  }

  // Toggle bookmark status
  @action
  void toggleBookmark(Movie movie) {
    if (isBookmarkedRx(movie)) {
      // Remove the movie from both MobX observable list and the global list
      bookmarkedMoviesRx.remove(movie);
    } else {
      // Add the movie to both MobX observable list and the global list
      bookmarkedMoviesRx.add(movie);
    }
  }

  // Fetch Now Showing movies using Future
  @action
  Future<void> fetchNowShowingMovies() async {
    nowShowingMovies = ObservableFuture(_apiService.getNowShowing());
  }

  // Fetch Popular movies using Future
  @action
  Future<void> fetchPopularMovies() async {
    popularMovies = ObservableFuture(_apiService.getPopular());
  }

  // Set up RxDart stream for Now Showing movies
  @observable
  ObservableStream<List<Movie>>? nowShowingMoviesRx;

  @action
  void listenToNowShowingWithRx() {
    nowShowingMoviesRx = ObservableStream(_apiService.nowShowingMoviesStream);
    _apiService.getNowShowingRX();
  }

  // Set up RxDart stream for Popular movies
  @observable
  ObservableStream<List<Movie>>? popularMoviesRx;

  @action
  void listenToPopularWithRx() {
    popularMoviesRx = ObservableStream(_apiService.popularMoviesStream);
    _apiService.getPopularRX();
  }

  // Set up RxDart stream for Upcoming movies
  @observable
  ObservableStream<List<Movie>>? upcomingMoviesRx;

  @action
  void listenToUpcomingWithRx() {
    upcomingMoviesRx = ObservableStream(_apiService.upcomingMoviesStream);
    _apiService.getUpcomingRX();
  }

  // Search movies with RxDart
  @action
  void searchMovieWithRx(String query) {
    _apiService.searchMoviesRX(query);
    searchResultRx = ObservableStream(_apiService.searchMoviesStream);
  }

  // Dispose resources
  void dispose() {
    _apiService.dispose();
  }
}
