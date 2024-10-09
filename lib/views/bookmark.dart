import 'package:flutter/cupertino.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key, required this.title, required this.isDarkMode});

  final String title;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
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
