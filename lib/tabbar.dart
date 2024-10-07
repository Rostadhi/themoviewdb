import 'package:flutter/cupertino.dart';
import 'package:otaku_movie_app/views/home.dart'; // Import the home page
import 'package:otaku_movie_app/views/moviesDetail.dart'; // Import the movie detail page
import 'package:otaku_movie_app/views/bookmark.dart'; // Import the bookmark page

class CupertinoTabBarPage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const CupertinoTabBarPage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.house_fill,
              color: isDarkMode ? CupertinoColors.white : CupertinoColors.black, // Icon color for dark/light mode
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.videocam_circle_fill,
              color: isDarkMode ? CupertinoColors.white : CupertinoColors.black, // Icon color for dark/light mode
            ),
            label: 'Movie Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.bookmark_fill,
              color: isDarkMode ? CupertinoColors.white : CupertinoColors.black, // Icon color for dark/light mode
            ),
            label: 'Bookmark',
          ),
        ],
        height: 70.0, // Adjust the height if needed
        backgroundColor: isDarkMode
            ? CupertinoColors.darkBackgroundGray.withOpacity(0.8) // Dark mode background
            : CupertinoColors.white.withOpacity(0.9), // Light mode background
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return MyHomePage(
                  title: 'Otaku Movie',
                  isDarkMode: isDarkMode,
                  toggleTheme: toggleTheme,
                );
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return MovieDetailsPage();
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return BookmarkPage();
              },
            );
          default:
            return CupertinoTabView(
              builder: (context) {
                return MyHomePage(
                  title: 'Otaku Movie',
                  isDarkMode: isDarkMode,
                  toggleTheme: toggleTheme,
                );
              },
            );
        }
      },
    );
  }
}
