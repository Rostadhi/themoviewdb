import 'package:flutter/cupertino.dart';
import 'package:otaku_movie_app/mobx_store.dart';
import 'package:otaku_movie_app/models/model.dart';
import '../bookmark.dart';

List<Movie> bookmarkedMovies = [];

class DetailScreen extends StatefulWidget {
  final Movie movie;
  final bool isDarkMode;
  final MovieStore store;

  const DetailScreen({
    super.key,
    required this.movie,
    required this.isDarkMode,
    required this.store,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentId = 0;
  late Future<List<Movie>> upcomingMovies;
  final MovieStore store = MovieStore();

  bool isBookmarked(Movie movie) {
    return bookmarkedMovies.contains(movie);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textColor = widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.movie.title ?? 'No Title Available'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => BookmarkPage(
                  title: 'Bookmarked Movies',
                  isDarkMode: widget.isDarkMode,
                  store: store,
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster
            Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.movie.backDropPath != null ? "https://image.tmdb.org/t/p/original/${widget.movie.backDropPath}" : "https://via.placeholder.com/500x750",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: CupertinoButton.filled(
                    child: const Text("Play Trailer"),
                    onPressed: () {
                      // Play trailer functionality
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Title and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.movie.title ?? 'No Title Available',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.star_fill,
                            color: textColor,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.movie.voteAverage != null ? '${widget.movie.voteAverage!.toStringAsFixed(1)}/10 IMDb' : 'No rating',
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Genres
                  if (widget.movie.genres != null && widget.movie.genres!.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: widget.movie.genres!
                          .map(
                            (genre) => CupertinoButton(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              color: textColor,
                              borderRadius: BorderRadius.circular(20),
                              child: Text(
                                genre.name,
                                style: const TextStyle(fontSize: 12),
                              ),
                              onPressed: () {},
                            ),
                          )
                          .toList(),
                    ),
                  const SizedBox(height: 20),

                  // Description
                  Text(
                    widget.movie.description ?? 'No Description Available',
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Additional Movie Information (Runtime, Release Date, Language)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoRow(
                        "Length",
                        widget.movie.runtime != null ? '${widget.movie.runtime} min' : 'N/A',
                      ),
                      _buildInfoRow(
                        "Release Date",
                        widget.movie.releaseDate ?? 'N/A',
                      ),
                      _buildInfoRow(
                        "Language",
                        widget.movie.originalLanguage ?? 'N/A',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Production Companies
                  const Text(
                    "Production Companies",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (widget.movie.productionCompanies != null && widget.movie.productionCompanies!.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: widget.movie.productionCompanies!
                          .map((company) => CupertinoButton(
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                color: textColor,
                                borderRadius: BorderRadius.circular(20),
                                child: Text(
                                  company.name,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                onPressed: () {},
                              ))
                          .toList(),
                    )
                  else
                    Text(
                      "No production company information available.",
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                  const SizedBox(height: 20),

                  // Check out button
                  Center(
                    child: CupertinoButton.filled(
                      child: const Text(
                        "Check Out",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build a row with movie information
  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
          ),
        ),
      ],
    );
  }
}
