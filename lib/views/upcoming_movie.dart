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
  int currentId = 16;
  late Future<List<Movie>> upcomingMovies;

  @override
  void initState() {
    super.initState();
    upcomingMovies = APIservice().getUpcoming();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.bookmark,
            color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
          ),
          onPressed: () {},
        ),
      ),
      child: FutureBuilder<List<Movie>>(
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
          final currentMovie = movies[currentId];

          return Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Upcoming Movie",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: CupertinoColors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Image of the current movie
              Expanded(
                child: PageView.builder(
                  itemCount: movies.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentId = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/original/${movies[index].posterPath ?? ''}",
                          width: 250,
                          height: 350,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Text("Image not available"));
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Movie title
              Text(
                currentMovie.title ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Movie tagline (or sub-title)
              Text(
                currentMovie.description ?? "No description available",
                style: const TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
              ),

              const SizedBox(height: 10),

              // Movie rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.star_fill,
                    color: CupertinoColors.systemYellow,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${currentMovie.voteAverage?.toStringAsFixed(1) ?? '0.0'} IMDb",
                    style: const TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Bookmark button
              CupertinoButton(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: CupertinoColors.black),
                  ),
                  child: const Text(
                    "Bookmark",
                    style: TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.black,
                    ),
                  ),
                ),
                onPressed: () {
                  // Add bookmark logic here
                },
              ),

              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
