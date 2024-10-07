import 'package:flutter/cupertino.dart';
import 'package:otaku_movie_app/tabbar.dart'; // Import the new TabBar file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  // Function to toggle the theme
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light, // Toggle between dark and light mode
      ),
      home: CupertinoTabBarPage(isDarkMode: isDarkMode, toggleTheme: toggleTheme),
    );
  }
}
