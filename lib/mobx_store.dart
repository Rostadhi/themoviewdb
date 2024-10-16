import 'package:mobx/mobx.dart';
import 'package:otaku_movie_app/api/service.dart';
import 'package:otaku_movie_app/models/model.dart';

part 'mobx_store.g.dart';

class MovieStore = _MovieStore with _$MovieStore;

abstract class _MovieStore with Store {
  // Observable for dark mode
  @observable
  bool isDarkMode = false;

  // Observable for selected language
  @observable
  String selectedLanguage = 'en';

  // Observable for now showing movies
  @observable
  ObservableFuture<List<Movie>>? nowShowingMovies;

  // Observable for popular movies
  @observable
  ObservableFuture<List<Movie>>? popularMovies;

  // Action to toggle the theme
  @action
  void toggleTheme() {
    isDarkMode = !isDarkMode;
  }

  // Action to change language
  @action
  void changeLanguage(String language) {
    selectedLanguage = language;
  }

  // Action to fetch now showing movies
  @action
  Future<void> fetchNowShowingMovies() async {
    nowShowingMovies = ObservableFuture(APIservice().getNowShowing());
  }

  // Action to fetch popular movies
  @action
  Future<void> fetchPopularMovies() async {
    popularMovies = ObservableFuture(APIservice().getPopular());
  }
}
