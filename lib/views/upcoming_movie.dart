import 'package:flutter/cupertino.dart';
import 'package:otaku_movie_app/api/service.dart';
import '../models/model.dart';

/*
1. build variable func for passing detail data from service
2. import service for api and model for variabel
*/
class UpcomingMovie extends StatefulWidget {
  const UpcomingMovie({
    super.key,
    required this.title,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  final String title;
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  @override
  State<UpcomingMovie> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<UpcomingMovie> {
  int currentId = 16;
  late Future<Movie> movieDetail;

  @override
  void initState() {
    super.initState();
    movieDetail = APIservice().getMovieDetail(currentId);
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Upcoming'),
      ),
      child: Center(
        child: Text(
          'This is the Upcoming Page',
          style: TextStyle(fontSize: 20), // Just an example of adding text
        ),
      ),
    );
  }
}
