// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MovieStore on _MovieStore, Store {
  late final _$isDarkModeAtom =
      Atom(name: '_MovieStore.isDarkMode', context: context);

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

  late final _$selectedLanguageAtom =
      Atom(name: '_MovieStore.selectedLanguage', context: context);

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

  late final _$nowShowingMoviesAtom =
      Atom(name: '_MovieStore.nowShowingMovies', context: context);

  @override
  ObservableFuture<List<Movie>>? get nowShowingMovies {
    _$nowShowingMoviesAtom.reportRead();
    return super.nowShowingMovies;
  }

  @override
  set nowShowingMovies(ObservableFuture<List<Movie>>? value) {
    _$nowShowingMoviesAtom.reportWrite(value, super.nowShowingMovies, () {
      super.nowShowingMovies = value;
    });
  }

  late final _$popularMoviesAtom =
      Atom(name: '_MovieStore.popularMovies', context: context);

  @override
  ObservableFuture<List<Movie>>? get popularMovies {
    _$popularMoviesAtom.reportRead();
    return super.popularMovies;
  }

  @override
  set popularMovies(ObservableFuture<List<Movie>>? value) {
    _$popularMoviesAtom.reportWrite(value, super.popularMovies, () {
      super.popularMovies = value;
    });
  }

  late final _$fetchNowShowingMoviesAsyncAction =
      AsyncAction('_MovieStore.fetchNowShowingMovies', context: context);

  @override
  Future<void> fetchNowShowingMovies() {
    return _$fetchNowShowingMoviesAsyncAction
        .run(() => super.fetchNowShowingMovies());
  }

  late final _$fetchPopularMoviesAsyncAction =
      AsyncAction('_MovieStore.fetchPopularMovies', context: context);

  @override
  Future<void> fetchPopularMovies() {
    return _$fetchPopularMoviesAsyncAction
        .run(() => super.fetchPopularMovies());
  }

  late final _$_MovieStoreActionController =
      ActionController(name: '_MovieStore', context: context);

  @override
  void toggleTheme() {
    final _$actionInfo = _$_MovieStoreActionController.startAction(
        name: '_MovieStore.toggleTheme');
    try {
      return super.toggleTheme();
    } finally {
      _$_MovieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeLanguage(String language) {
    final _$actionInfo = _$_MovieStoreActionController.startAction(
        name: '_MovieStore.changeLanguage');
    try {
      return super.changeLanguage(language);
    } finally {
      _$_MovieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkMode: ${isDarkMode},
selectedLanguage: ${selectedLanguage},
nowShowingMovies: ${nowShowingMovies},
popularMovies: ${popularMovies}
    ''';
  }
}
