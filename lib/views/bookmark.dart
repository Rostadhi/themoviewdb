import 'package:flutter/cupertino.dart';
import '../models/model.dart';

class BookmarkPage extends StatelessWidget {
  final String title;
  final bool isDarkMode;
  final List<Movie> bookmarkedMovies;

  const BookmarkPage({
    super.key,
    required this.title,
    required this.isDarkMode,
    required this.bookmarkedMovies,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? CupertinoColors.white : CupertinoColors.black;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title, style: TextStyle(color: textColor)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: bookmarkedMovies.isEmpty
              ? const Center(
                  child: Text('No bookmarked movies available.'),
                )
              : ListView.builder(
                  itemCount: bookmarkedMovies.length,
                  itemBuilder: (context, index) {
                    final movie = bookmarkedMovies[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Movie Poster
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              movie.posterPath != null ? 'https://image.tmdb.org/t/p/w500/${movie.posterPath}' : 'https://via.placeholder.com/300x450.png?text=No+Image',
                              width: 100,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Movie Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Movie Title
                                Text(
                                  movie.title ?? 'No Title',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                                const SizedBox(height: 5),

                                // Movie Rating
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.star_fill,
                                      color: CupertinoColors.systemYellow,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      (movie.voteAverage != null && movie.voteAverage! > 0) ? '${movie.voteAverage!.toStringAsFixed(1)}/10 IMDb' : 'No rating available',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),

                                // Movie Genres (assuming genres are available in the model)
                                Wrap(
                                  spacing: 6.0,
                                  runSpacing: 6.0,
                                  children: movie.genres != null
                                      ? movie.genres!
                                          .map(
                                            (genre) => Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: CupertinoColors.systemGrey5,
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: Text(
                                                genre.name,
                                                style: const TextStyle(fontSize: 10),
                                              ),
                                            ),
                                          )
                                          .toList()
                                      : [],
                                ),
                                const SizedBox(height: 5),

                                // Movie Duration (assuming runtime is in minutes)
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.time,
                                      color: CupertinoColors.systemBlue,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      movie.runtime != null ? '${(movie.runtime! ~/ 60)}h ${(movie.runtime! % 60)}m' : 'Unknown Duration',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
