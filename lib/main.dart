import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:otaku_movie_app/api/service.dart';
import '../models/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'OMO -> Otaku Movie',
      theme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: MyHomePage(
        title: 'Otaku Movie',
        isDarkMode: isDarkMode,
        toggleTheme: toggleTheme,
      ),
    );
  }
}

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

  @override
  void initState() {
    nowShowing = APIservice().getNowShowing();
    popularMovies = APIservice().getPopular();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            widget.isDarkMode ? CupertinoIcons.sun_max : CupertinoIcons.moon,
            color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
          ),
          onPressed: widget.toggleTheme,
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
          onPressed: () {},
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
                Text(
                  "Now Showing",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                  future: nowShowing,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    final movies = snapshot.data!;
                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                Text(
                                  movie.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: const [
                                    Icon(
                                      CupertinoIcons.star_fill,
                                      color: CupertinoColors.systemYellow,
                                      size: 14,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "9.1/10 IMDb",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "Popular Movies",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                  ),
                ),
                FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    final movies = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return Padding(
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
                                    Text(
                                      movie.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: widget.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: const [
                                        Icon(
                                          CupertinoIcons.star_fill,
                                          color: CupertinoColors.systemYellow,
                                          size: 14,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "6.4/10 IMDb",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
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
                                    Row(
                                      children: const [
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
