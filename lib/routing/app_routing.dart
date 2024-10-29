import 'package:flutter/cupertino.dart';
import 'package:otaku_movie_app/models/model.dart';
import 'package:otaku_movie_app/views/sub_view/detail_page.dart';
import 'package:otaku_movie_app/views/sub_view/search_result.dart';
import 'package:otaku_movie_app/views/bookmark.dart';
import 'package:otaku_movie_app/mobx_store.dart';

/*
1. route to detail page -> home
2. route to search page -> home
3. route to bookmark page -> bookmark
*/

class AppRouter {
  final MovieStore store;
  final bool isDarkMode;
  final String bookmarkTitle;

  AppRouter({
    required this.store,
    required this.isDarkMode,
    this.bookmarkTitle = "Bookmarks",
    required String title,
  });

  void navigateToDetailPage(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => DetailScreen(
          movie: movie,
          isDarkMode: isDarkMode,
          store: store,
        ),
      ),
    );
  }

  void navigateToSearchPage(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => SearchResultPage(isDarkMode: isDarkMode, store: store),
      ),
    );
  }

  void navigateToBookmarkPage(BuildContext context, {String? title}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => BookmarkPage(title: title ?? bookmarkTitle, isDarkMode: isDarkMode, store: store),
      ),
    );
  }
}
