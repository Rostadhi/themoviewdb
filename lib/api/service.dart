import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:otaku_movie_app/models/model.dart';

const apiKey = "589b8a5511310b4abb4382fe9d23b31c";

class APIservice {
  // Discover Now Showing Animation/Anime Movies (Released after a certain date)
  final nowShowingApi = "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=16&primary_release_date.gte=2023-01-01";

  // Discover Popular Animation/Anime Movies
  final popularApi = "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=16&sort_by=popularity.desc";

  // Upcoming Movie
  final upcomingMovieApi = "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=16&primary_release_date.gte=2024-10-01&sort_by=release_date.asc";

  String getMovieDetailApi(int movieId) {
    return "https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey";
  }

  // Search Movie
  Uri getSearchMovieApi(String query) {
    return Uri.parse("https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query&with_genres=16");
  }

  // Fetch 'Now Showing' Animation Movies
  Future<List<Movie>> getNowShowing() async {
    Uri url = Uri.parse(nowShowingApi);
    final response = await http.get(url);

    /// you can add another status code for debugging
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data: ${response.body}");
    }
  }

  // Fetch Popular Animation Movies
  Future<List<Movie>> getPopular() async {
    Uri url = Uri.parse(popularApi);
    final response = await http.get(url);

    /// you can add another status code for debugging
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data: ${response.body}");
    }
  }

  // Fetch Upcoming Movies
  Future<List<Movie>> getUpcoming() async {
    Uri url = Uri.parse(upcomingMovieApi);
    final response = await http.get(url);

    /// you can add another status code for debugging
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data: ${response.body}");
    }
  }

  // Fetch Detailed Movie Info by Movie ID
  Future<Movie> getMovieDetail(int movieId) async {
    Uri url = Uri.parse(getMovieDetailApi(movieId));
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Movie.fromMap(data); // Convert JSON to Movie model
    } else {
      throw Exception("Failed to load movie details: ${response.body}");
    }
  }

  // Search Movies by Query
  Future<List<Movie>> searchMovies(String query) async {
    Uri url = getSearchMovieApi(query); // Get dynamic URL for search
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      // Convert the search results into Movie objects
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();

      // Filter out movies that don't contain the 'Animation' genre (ID: 16)
      List<Movie> filteredMovies = movies.where((movie) {
        return movie.genreIds?.contains(16) ?? false; // Ensure it has genre ID 16 (Animation)
      }).toList();

      return filteredMovies; // Return only the filtered animation movies
    } else {
      throw Exception("Failed to load search results: ${response.body}");
    }
  }
}
