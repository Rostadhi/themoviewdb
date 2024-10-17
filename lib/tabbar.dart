import 'package:flutter/cupertino.dart';
import 'package:otaku_movie_app/views/home.dart';
import 'package:otaku_movie_app/views/sub_view/detail_page.dart';
import 'package:otaku_movie_app/views/upcoming_movie.dart';
import 'package:otaku_movie_app/views/bookmark.dart';

class MainTabBar extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  final Function(Locale) setLocale;

  const MainTabBar({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
    required this.setLocale,
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
            );
          case 1:
            return UpcomingMovie(title: "Upcoming Movie", isDarkMode: isDarkMode);
          case 2:
            return BookmarkPage(
              title: "Bookmark Movie",
              isDarkMode: isDarkMode,
              bookmarkedMovies: bookmarkedMovies,
            );
          default:
            return Container();
        }
      },
    );
  }
}
