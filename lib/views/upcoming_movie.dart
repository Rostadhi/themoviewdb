import 'package:flutter/cupertino.dart';
import 'bookmark.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:otaku_movie_app/mobx_store.dart';

class UpcomingMovie extends StatelessWidget {
  final String title;
  final bool isDarkMode;

  final MovieStore store = MovieStore();

  UpcomingMovie({
    super.key,
    required this.title,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    // Start listening to upcoming movies stream using RX Dart
    store.listenToUpcomingWithRx();

    final textColor = isDarkMode ? CupertinoColors.white : CupertinoColors.black;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          title,
          style: TextStyle(color: textColor),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            // Navigate to BookmarkPage and pass the bookmarkedMovies list from MobX store
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => BookmarkPage(
                  title: 'Bookmarked Movies',
                  isDarkMode: isDarkMode,
                  bookmarkedMovies: store.bookmarkedMovies.toList(),
                ),
              ),
            );
          },
          child: Icon(
            CupertinoIcons.bookmark,
            color: textColor,
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "List Of Upcoming Movies",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Observer(
                  builder: (_) {
                    // Observe the RX Dart stream-based observable for upcoming movies
                    final upcomingMoviesStream = store.upcomingMoviesRx?.value;

                    if (upcomingMoviesStream == null) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (upcomingMoviesStream.isEmpty) {
                      return const Center(child: Text('No upcoming movies found.'));
                    }

                    final movies = upcomingMoviesStream;
                    return SizedBox(
                      height: 600,
                      child: PageView.builder(
                        itemCount: movies.length,
                        controller: PageController(viewportFraction: 0.8),
                        itemBuilder: (context, index) {
                          final movie = movies[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Transform.scale(
                              scale: index == store.bookmarkedMovies.indexOf(movie) ? 1.0 : 0.9,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      movie.posterPath != null ? 'https://image.tmdb.org/t/p/w500/${movie.posterPath}' : 'https://via.placeholder.com/300x450.png?text=No+Image',
                                      fit: BoxFit.cover,
                                      width: 300,
                                      height: 400,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Center(
                                    child: Text(
                                      movie.title ?? 'No Title',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        CupertinoIcons.star_circle_fill,
                                        color: CupertinoColors.systemYellow,
                                        size: 32,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        (movie.popularity != null && movie.popularity! > 0) ? '${movie.popularity!.toStringAsFixed(3)} IMDb Popularity' : 'No popularity available',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  CupertinoButton(
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                    color: store.isBookmarked(movie) ? CupertinoColors.systemRed : CupertinoColors.systemGrey5,
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(CupertinoIcons.bookmark),
                                        SizedBox(width: 10),
                                        Text('Bookmark'),
                                      ],
                                    ),
                                    onPressed: () {
                                      if (store.isBookmarked(movie)) {
                                        store.bookmarkedMovies.remove(movie);
                                      } else {
                                        store.bookmarkedMovies.add(movie);
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 20),
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
