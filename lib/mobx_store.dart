import 'package:mobx/mobx.dart';
import 'package:otaku_movie_app/api/service.dart';
import 'package:otaku_movie_app/models/model.dart';

part 'mobx_store.g.dart';

class MovieStore = _MovieStore with _$MovieStore;

abstract class _MovieStore with Store {
  // variable that implemented accross the views

  // dark mode
  @observable
  bool isDarkMode = false;

  // title
  @observable
  String title = '';

  // localization
  @observable
  String selectedLanguage = 'en';

  // bookmark
  @observable
  ObservableList<Movie> bookmarkedMovies = ObservableList<Movie>();

  // now showing
  @observable
  ObservableFuture<List<Movie>>? nowShowingMovies;

  // popular
  @observable
  ObservableFuture<List<Movie>>? popularMovies;

  // upcoming
  @observable
  ObservableFuture<List<Movie>>? upComingMovies;

  // detail

  // search

  // action to trigger the function

  // toggle action for dark mode
  @action
  void toggleTheme() {
    isDarkMode = !isDarkMode;
  }

  // change action for different language
  @action
  void changeLanguage(String language) {
    selectedLanguage = language;
  }

  // action for bookmark
  @action
  bool isBookmarked(Movie movie) {
    return bookmarkedMovies.contains(movie);
  }

  // fetch now showing
  @action
  Future<void> fetchNowShowingMovies() async {
    nowShowingMovies = ObservableFuture(APIservice().getNowShowing());
  }

  // fetch popular
  @action
  Future<void> fetchPopularMovies() async {
    popularMovies = ObservableFuture(APIservice().getPopular());
  }

  // fetch upcoming
  @action
  Future<void> fetchupComingMovies() async {
    popularMovies = ObservableFuture(APIservice().getUpcoming());
  }
}
