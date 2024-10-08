import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otaku_movie_app/models/model.dart';

const apiKey = "589b8a5511310b4abb4382fe9d23b31c";

class APIservice {
  // Discover Now Showing Animation/Anime Movies (Released after a certain date)
  final nowShowingApi = "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=16&primary_release_date.gte=2023-01-01";

  // Discover Popular Animation/Anime Movies
  final popularApi = "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=16&sort_by=popularity.desc";

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

  // Fetch Detailed Movie Info by Movie ID
  Future<Movie> getMovieDetail(int movieId) async {
    final movieDetailsApi = "https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey";

    Uri url = Uri.parse(movieDetailsApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Movie.fromMap(data); // Convert JSON to Movie model
    } else {
      throw Exception("Failed to load movie details: ${response.body}");
    }
  }
}
