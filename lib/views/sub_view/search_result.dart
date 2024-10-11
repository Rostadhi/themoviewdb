import 'package:flutter/cupertino.dart';
import 'package:otaku_movie_app/api/service.dart';
import 'package:otaku_movie_app/models/model.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  String searchQuery = '';
  Future<List<Movie>>? searchResults;

  // Method to search movies using the search query
  void searchMovies(String query) {
    setState(() {
      searchQuery = query;
      searchResults = APIservice().searchMovies(query); // Call the API service method to search movies
    });
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Search Movies'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Search Text Field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoSearchTextField(
                placeholder: "Search anime/animation movies...",
                onSubmitted: (query) {
                  searchMovies(query); // Trigger the searchMovies function on submit
                },
              ),
            ),
            const SizedBox(height: 20),

            // Display search results based on the search query
            searchResults == null
                ? const Center(child: Text('Search for movies...'))
                : Expanded(
                    child: FutureBuilder<List<Movie>>(
                      future: searchResults,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CupertinoActivityIndicator()); // Show a loading indicator while fetching results
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}')); // Show error if something goes wrong
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No movies found.')); // Show a message if no movies are found
                        }

                        final movies = snapshot.data!; // Extract movies from the snapshot

                        // List of movie search results
                        return ListView.builder(
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                              child: Row(
                                children: [
                                  // Movie Poster
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      movie.posterPath != null ? 'https://image.tmdb.org/t/p/w500/${movie.posterPath}' : 'https://via.placeholder.com/100x150.png?text=No+Image', // Use a placeholder if the image is not available
                                      width: 50,
                                      height: 75,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 10),

                                  // Movie Title and Rating
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title ?? 'No title available',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          (movie.voteAverage != null && movie.voteAverage! > 0) ? '${movie.voteAverage!.toStringAsFixed(1)}/10 IMDb' : 'No rating available',
                                          style: const TextStyle(fontSize: 12),
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
    );
  }
}
