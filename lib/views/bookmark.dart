import 'package:flutter/cupertino.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({
    super.key,
    required this.title,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  final String title;
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Bookmark Page'),
      ),
      child: Center(
        child: Text(
          'This is the Bookmark Page',
          style: TextStyle(fontSize: 20), // Just an example of adding text
        ),
      ),
    );
  }
}
