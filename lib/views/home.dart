import 'package:flutter/cupertino.dart';
import 'package:otaku_movie_app/api/service.dart';
import '../models/model.dart';
import '../views/sub_view/search_result.dart';
import '../views/sub_view/detail_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  final String title;
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Movie>> nowShowing;
  late Future<List<Movie>> popularMovies;

  String _selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    nowShowing = APIservice().getNowShowing();
    popularMovies = APIservice().getPopular();
  }

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  void _showLanguageSelection(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: const Text('Select Language'),
        actions: [
          CupertinoActionSheetAction(
            child: const Text('English'),
            onPressed: () {
              _changeLanguage('en');
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Spanish'),
            onPressed: () {
              _changeLanguage('es');
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Indonesia'),
            onPressed: () {
              _changeLanguage('in');
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: widget.toggleTheme,
              child: Icon(
                widget.isDarkMode ? CupertinoIcons.sun_max : CupertinoIcons.moon,
                color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                _showLanguageSelection(context);
              },
              child: Icon(
                CupertinoIcons.globe,
                color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
              ),
            ),
          ],
        ),
        middle: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.search,
            color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
          ),
          onPressed: () {
            // Navigate to the SearchResultPage
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => SearchResultPage(isDarkMode: widget.isDarkMode), // Navigate to the search page
              ),
            );
          }, // make search is actionable -> make keyboard appear and textable after user typing some keyword it can press enter and then after that go to the search result
        ),
        backgroundColor: widget.isDarkMode ? CupertinoColors.black.withOpacity(0.8) : CupertinoColors.white,
      ),
      child: SafeArea(
        // This ensures content won't overlap with the navigation bar
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Now Showing Section
                Text(
                  "Now Showing",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                FutureBuilder<List<Movie>>(
                  future: nowShowing,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show loading indicator while waiting for the API response
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (snapshot.hasError) {
                      // Handle errors during the API call
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      // Handle the case where no movies are returned
                      return const Center(child: Text('No movies available.'));
                    }

                    final movies = snapshot.data!;
                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigate to the detail screen when tapped
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => DetailScreen(
                                    movie: movie,
                                    isDarkMode: widget.isDarkMode,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Movie Poster
                                  Container(
                                    width: 150,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage("https://image.tmdb.org/t/p/original/${movie.backDropPath}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),

                                  // Movie Title with Ellipsis if too long
                                  SizedBox(
                                    width: 150, // Limit the width of the title text to fit the card width
                                    child: Text(
                                      movie.title ?? 'No title available',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis, // Truncate long titles
                                    ),
                                  ),

                                  const SizedBox(height: 2),

                                  // Movie Rating (don't show if it's 0.0)
                                  Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.star_fill,
                                        color: CupertinoColors.systemYellow,
                                        size: 14,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        (movie.voteAverage != null && movie.voteAverage! > 0) ? '${movie.voteAverage!.toStringAsFixed(1)}/10 IMDb' : 'No rating available',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Popular Movies Section
                Text(
                  "Popular Movies",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                  ),
                ),
                FutureBuilder<List<Movie>>(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show loading indicator while waiting for the API response
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (snapshot.hasError) {
                      // Handle errors during the API call
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      // Handle the case where no movies are returned
                      return const Center(child: Text('No movies available.'));
                    }

                    final movies = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the detail screen when tapped
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => DetailScreen(
                                  movie: movie,
                                  isDarkMode: widget.isDarkMode,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage("https://image.tmdb.org/t/p/original/${movie.backDropPath}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Movie Title
                                      Text(
                                        movie.title ?? 'No title available',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),

                                      // Movie Rating
                                      Row(
                                        children: [
                                          const Icon(
                                            CupertinoIcons.star_fill,
                                            color: CupertinoColors.systemYellow,
                                            size: 14,
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
                                      Row(
                                        children: [
                                          _buildGenreChip("Horror", widget.isDarkMode),
                                          const SizedBox(width: 5),
                                          _buildGenreChip("Mystery", widget.isDarkMode),
                                          const SizedBox(width: 5),
                                          _buildGenreChip("Thriller", widget.isDarkMode),
                                        ],
                                      ),
                                      const SizedBox(height: 5),

                                      // Movie Duration
                                      const Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.time,
                                            size: 14,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "1h 47m",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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

  // Helper function to build genre chips
  Widget _buildGenreChip(String genre, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode ? CupertinoColors.systemGrey.withOpacity(0.5) : CupertinoColors.systemGrey.withOpacity(0.2),
      ),
      child: Text(
        genre,
        style: TextStyle(
          fontSize: 12,
          color: isDarkMode ? CupertinoColors.white : CupertinoColors.black,
        ),
      ),
    );
  }
}
