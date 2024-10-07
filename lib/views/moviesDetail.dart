import 'package:flutter/cupertino.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
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
