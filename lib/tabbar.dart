import 'package:flutter/cupertino.dart';
import 'package:otaku_movie_app/views/home.dart';
import 'package:otaku_movie_app/views/upcoming_movie.dart';
import 'package:otaku_movie_app/views/bookmark.dart';
import 'package:otaku_movie_app/mobx_store.dart';

class MainTabBar extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  final Function(Locale) setLocale;
  final MovieStore store;

  const MainTabBar({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
    required this.setLocale,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.film), label: 'Upcoming'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.bookmark), label: 'Bookmark'),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return MyHomePage(
              isDarkMode: isDarkMode,
              toggleTheme: toggleTheme,
              setLocale: setLocale,
              store: store,
            );
          case 1:
            return UpcomingMovie(
              title: "Upcoming Movie",
              isDarkMode: isDarkMode,
              store: store,
            );
          case 2:
            return BookmarkPage(
              title: "Bookmark Movie",
              isDarkMode: isDarkMode,
              store: store,
            );
          default:
            return Container();
        }
      },
    );
  }
}
