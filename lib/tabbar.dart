import 'package:flutter/cupertino.dart';
import 'package:otaku_movie_app/views/home.dart'; // Import the home page
import 'package:otaku_movie_app/views/movies_detail.dart'; // Import the movie detail page
import 'package:otaku_movie_app/views/bookmark.dart'; // Import the bookmark page

class MainTabBar extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const MainTabBar({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.film), label: 'Movie Details'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.bookmark), label: 'Bookmark'),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return MyHomePage(title: "Otaku Movie", isDarkMode: isDarkMode, toggleTheme: toggleTheme);
          case 1:
            return MovieDetailsPage(title: "Detail Movie", isDarkMode: isDarkMode, toggleTheme: toggleTheme); // Other pages also respond to dark mode
          case 2:
            return BookmarkPage(title: "Bookmark Movie", isDarkMode: isDarkMode, toggleTheme: toggleTheme);
          default:
            return Container();
        }
      },
    );
  }
}
