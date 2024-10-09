import 'package:flutter/cupertino.dart';
import 'package:otaku_movie_app/models/model.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.movie.title ?? 'No Title Available'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.bookmark),
          onPressed: () {
            // Bookmark or favorite functionality
          },
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
                          const Icon(
                            CupertinoIcons.star_fill,
                            color: CupertinoColors.systemYellow,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.movie.voteAverage != null ? '${widget.movie.voteAverage!.toStringAsFixed(1)}/10 IMDb' : 'No rating',
                            style: const TextStyle(
                              fontSize: 16,
                              color: CupertinoColors.systemGrey,
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
                              color: CupertinoColors.systemGrey5,
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
                    style: const TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
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
                                color: CupertinoColors.systemGrey5,
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
                    const Text(
                      "No production company information available.",
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.inactiveGray,
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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: CupertinoColors.inactiveGray,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: CupertinoColors.black,
          ),
        ),
      ],
    );
  }
}
