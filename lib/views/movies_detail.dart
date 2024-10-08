import 'package:flutter/cupertino.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({
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
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Movie Details'),
      ),
      child: Center(
        child: Text(
          'This is the Movie Details Page',
          style: TextStyle(fontSize: 20), // Just an example of adding text
        ),
      ),
    );
  }
}
