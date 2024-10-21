// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MovieStore on _MovieStore, Store {
  late final _$isDarkModeAtom = Atom(name: '_MovieStore.isDarkMode', context: context);

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  late final _$titleAtom = Atom(name: '_MovieStore.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$selectedLanguageAtom = Atom(name: '_MovieStore.selectedLanguage', context: context);

  @override
  String get selectedLanguage {
    _$selectedLanguageAtom.reportRead();
    return super.selectedLanguage;
  }

  @override
  set selectedLanguage(String value) {
    _$selectedLanguageAtom.reportWrite(value, super.selectedLanguage, () {
      super.selectedLanguage = value;
    });
  }

  late final _$searchResultAtom = Atom(name: '_MovieStore.searchResult', context: context);

  @override
  ObservableStream<List<Movie>>? get searchResult {
    _$searchResultAtom.reportRead();
    return super.searchResult;
  }

  @override
  set searchResult(ObservableStream<List<Movie>>? value) {
    _$searchResultAtom.reportWrite(value, super.searchResult, () {
      super.searchResult = value;
    });
  }

  late final _$bookmarkedMoviesAtom = Atom(name: '_MovieStore.bookmarkedMovies', context: context);

  @override
  ObservableList<Movie> get bookmarkedMovies {
    _$bookmarkedMoviesAtom.reportRead();
    return super.bookmarkedMovies;
  }

  @override
  set bookmarkedMovies(ObservableList<Movie> value) {
    _$bookmarkedMoviesAtom.reportWrite(value, super.bookmarkedMovies, () {
      super.bookmarkedMovies = value;
    });
  }

  late final _$nowShowingMoviesAtom = Atom(name: '_MovieStore.nowShowingMovies', context: context);

  @override
  ObservableStream<List<Movie>>? get nowShowingMovies {
    _$nowShowingMoviesAtom.reportRead();
    return super.nowShowingMovies;
  }

  @override
  set nowShowingMovies(ObservableStream<List<Movie>>? value) {
    _$nowShowingMoviesAtom.reportWrite(value, super.nowShowingMovies, () {
      super.nowShowingMovies = value;
    });
  }

  late final _$popularMoviesAtom = Atom(name: '_MovieStore.popularMovies', context: context);

  @override
  ObservableStream<List<Movie>>? get popularMovies {
    _$popularMoviesAtom.reportRead();
    return super.popularMovies;
  }

  @override
  set popularMovies(ObservableStream<List<Movie>>? value) {
    _$popularMoviesAtom.reportWrite(value, super.popularMovies, () {
      super.popularMovies = value;
    });
  }

  late final _$upcomingMoviesAtom = Atom(name: '_MovieStore.upcomingMovies', context: context);

  @override
  ObservableStream<List<Movie>>? get upcomingMovies {
    _$upcomingMoviesAtom.reportRead();
    return super.upcomingMovies;
  }

  @override
  set upcomingMovies(ObservableStream<List<Movie>>? value) {
    _$upcomingMoviesAtom.reportWrite(value, super.upcomingMovies, () {
      super.upcomingMovies = value;
    });
  }

  late final _$loadBookmarkedMoviesAsyncAction = AsyncAction('_MovieStore.loadBookmarkedMovies', context: context);

  @override
  Future<void> loadBookmarkedMovies() {
    return _$loadBookmarkedMoviesAsyncAction.run(() => super.loadBookmarkedMovies());
  }

  late final _$toggleBookmarkAsyncAction = AsyncAction('_MovieStore.toggleBookmark', context: context);

  @override
  Future<void> toggleBookmark(Movie movie) {
    return _$toggleBookmarkAsyncAction.run(() => super.toggleBookmark(movie));
  }

  late final _$_MovieStoreActionController = ActionController(name: '_MovieStore', context: context);

  @override
  void toggleTheme() {
    final _$actionInfo = _$_MovieStoreActionController.startAction(name: '_MovieStore.toggleTheme');
    try {
      return super.toggleTheme();
    } finally {
      _$_MovieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeLanguage(String language) {
    final _$actionInfo = _$_MovieStoreActionController.startAction(name: '_MovieStore.changeLanguage');
    try {
      return super.changeLanguage(language);
    } finally {
      _$_MovieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isBookmarked(Movie movie) {
    final _$actionInfo = _$_MovieStoreActionController.startAction(name: '_MovieStore.isBookmarked');
    try {
      return super.isBookmarked(movie);
    } finally {
      _$_MovieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listenToNowShowingMovies() {
    final _$actionInfo = _$_MovieStoreActionController.startAction(name: '_MovieStore.listenToNowShowingMovies');
    try {
      return super.listenToNowShowingMovies();
    } finally {
      _$_MovieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listenToPopularMovies() {
    final _$actionInfo = _$_MovieStoreActionController.startAction(name: '_MovieStore.listenToPopularMovies');
    try {
      return super.listenToPopularMovies();
    } finally {
      _$_MovieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listenToUpcomingMovies() {
    final _$actionInfo = _$_MovieStoreActionController.startAction(name: '_MovieStore.listenToUpcomingMovies');
    try {
      return super.listenToUpcomingMovies();
    } finally {
      _$_MovieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchMovies(String query) {
    final _$actionInfo = _$_MovieStoreActionController.startAction(name: '_MovieStore.searchMovies');
    try {
      return super.searchMovies(query);
    } finally {
      _$_MovieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkMode: ${isDarkMode},
title: ${title},
selectedLanguage: ${selectedLanguage},
searchResult: ${searchResult},
bookmarkedMovies: ${bookmarkedMovies},
nowShowingMovies: ${nowShowingMovies},
popularMovies: ${popularMovies},
upcomingMovies: ${upcomingMovies}
    ''';
  }
}
