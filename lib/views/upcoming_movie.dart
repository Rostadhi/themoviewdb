import 'package:flutter/cupertino.dart';
import 'package:otaku_movie_app/api/service.dart';
import '../models/model.dart';

class UpcomingMovie extends StatefulWidget {
  const UpcomingMovie({
    super.key,
    required this.title,
    required this.isDarkMode,
  });

  final String title;
  final bool isDarkMode;

  @override
  State<UpcomingMovie> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingMovie> {
  int currentId = 0;
  late Future<List<Movie>> upcomingMovies;

  @override
  void initState() {
    super.initState();
    upcomingMovies = APIservice().getUpcoming();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          widget.title,
          style: TextStyle(color: textColor),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "List Of Upcoming Movies",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: CupertinoColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FutureBuilder<List<Movie>>(
                  future: upcomingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No upcoming movies found.'));
                    }

                    final movies = snapshot.data!;

                    return SizedBox(
                      height: 600,
                      child: PageView.builder(
                        onPageChanged: (index) {
                          setState(() {
                            currentId = index;
                          });
                        },
                        itemCount: movies.length,
                        controller: PageController(viewportFraction: 0.8),
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Transform.scale(
                              scale: index == currentId ? 1.0 : 0.9, // Shrink effect on non-centered items
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      movie.backDropPath != null ? 'https://image.tmdb.org/t/p/w500/${movie.backDropPath}' : 'https://via.placeholder.com/300x450.png?text=No+Image',
                                      fit: BoxFit.cover,
                                      width: 300, // Set the desired width
                                      height: 400, // Set the desired height
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    movie.title ?? 'No Title',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        CupertinoIcons.star_fill,
                                        color: CupertinoColors.systemYellow,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${movie.voteAverage?.toStringAsFixed(1) ?? 'N/A'} IMDb',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  CupertinoButton(
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                    color: CupertinoColors.systemGrey5,
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(CupertinoIcons.bookmark),
                                        SizedBox(width: 10),
                                        Text('Bookmark'),
                                      ],
                                    ),
                                    onPressed: () {
                                      // Add bookmark functionality
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
