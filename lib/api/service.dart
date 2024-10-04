import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otaku_movie_app/models/model.dart';

const apiKey = "589b8a5511310b4abb4382fe9d23b31c";

class APIservice {
  final nowShowingApi = "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey";
  final upComingApi = "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";
  final popularApi = "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey";

  Future<List<Movie>> getNowShowing() async {
    Uri url = Uri.parse(nowShowingApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<List<Movie>> getPopular() async {
    Uri url = Uri.parse(popularApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
