import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:otaku_movie_app/mobx_store.dart';

class SearchResultPage extends StatelessWidget {
  final bool isDarkMode;
  final MovieStore store;

  const SearchResultPage({
    super.key,
    required this.isDarkMode,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? CupertinoColors.white : CupertinoColors.black;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Search Movies'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Search Text Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CupertinoSearchTextField(
                  placeholder: "Search anime/animation movies...",
                  onSubmitted: (query) {
                    store.searchMovies(query); // Use MobX store to perform search
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Display search results based on the store's observable
              Expanded(
                child: Observer(
                  builder: (_) {
                    if (store.searchResult == null || store.searchResult!.status == FutureStatus.pending) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (store.searchResult!.status == FutureStatus.rejected) {
                      return Center(child: Text('Error: ${store.searchResult!.error}'));
                    } else if (store.searchResult!.value == null || store.searchResult!.value!.isEmpty) {
                      return const Center(child: Text('No movies found.'));
                    }

                    final movies = store.searchResult!.value!;

                    // List of movie search results
                    return ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
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

                                    // Movie Genres
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

                                    // Movie Duration
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
