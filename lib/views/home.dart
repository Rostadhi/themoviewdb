import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:otaku_movie_app/api/service.dart';
import '../models/model.dart';
import '../views/sub_view/search_result.dart';
import '../views/sub_view/detail_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:otaku_movie_app/mobx_store.dart';

class MyHomePage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  final Function(Locale) setLocale;

  final MovieStore store = MovieStore(); // MobX store instance

  MyHomePage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
    required this.setLocale,
  });

  void _showLanguageSelection(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: const Text('Select Language'),
        actions: [
          CupertinoActionSheetAction(
            child: const Text('English'),
            onPressed: () {
              setLocale(const Locale('en'));
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Spanish'),
            onPressed: () {
              setLocale(const Locale('es'));
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Indonesia'),
            onPressed: () {
              setLocale(const Locale('id'));
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
    // Fetch movies when the widget is built
    store.fetchNowShowingMovies();
    store.fetchPopularMovies();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: toggleTheme,
              child: Observer(
                builder: (_) => Icon(
                  store.isDarkMode ? CupertinoIcons.sun_max : CupertinoIcons.moon,
                  color: store.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                ),
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                _showLanguageSelection(context);
              },
              child: Observer(
                builder: (_) => Icon(
                  CupertinoIcons.globe,
                  color: store.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                ),
              ),
            ),
          ],
        ),
        middle: Observer(
          builder: (_) => Text(
            "Otaku Movie",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: store.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Observer(
                  builder: (_) => Text(
                    AppLocalizations.of(context)!.now_showing,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: store.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Observer(
                  builder: (_) {
                    if (store.nowShowingMovies == null || store.nowShowingMovies!.status == FutureStatus.pending) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (store.nowShowingMovies!.status == FutureStatus.rejected) {
                      return Center(child: Text('Error: ${store.nowShowingMovies!.error}'));
                    } else if (store.nowShowingMovies!.value == null || store.nowShowingMovies!.value!.isEmpty) {
                      return const Center(child: Text('No movies available.'));
                    }

                    final movies = store.nowShowingMovies!.value!;
                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => DetailScreen(
                                    movie: movie,
                                    isDarkMode: store.isDarkMode,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
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
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      movie.title ?? 'No title available',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: store.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
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
                Observer(
                  builder: (_) => Text(
                    AppLocalizations.of(context)!.popular_movies,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: store.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                    ),
                  ),
                ),
                Observer(
                  builder: (_) {
                    if (store.popularMovies == null || store.popularMovies!.status == FutureStatus.pending) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (store.popularMovies!.status == FutureStatus.rejected) {
                      return Center(child: Text('Error: ${store.popularMovies!.error}'));
                    } else if (store.popularMovies!.value == null || store.popularMovies!.value!.isEmpty) {
                      return const Center(child: Text('No movies available.'));
                    }

                    final movies = store.popularMovies!.value!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => DetailScreen(
                                  movie: movie,
                                  isDarkMode: store.isDarkMode,
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
                                      Text(
                                        movie.title ?? 'No title available',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: store.isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
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
                                      Row(
                                        children: [
                                          _buildGenreChip("Horror", store.isDarkMode),
                                          const SizedBox(width: 5),
                                          _buildGenreChip("Mystery", store.isDarkMode),
                                          const SizedBox(width: 5),
                                          _buildGenreChip("Thriller", store.isDarkMode),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
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
