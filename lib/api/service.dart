import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import '../models/model.dart';

const apiKey = "589b8a5511310b4abb4382fe9d23b31c";

class APIservice {
  final _nowShowingMoviesSubject = BehaviorSubject<List<Movie>>();
  final _popularMoviesSubject = BehaviorSubject<List<Movie>>();
  final _upcomingMoviesSubject = BehaviorSubject<List<Movie>>();
  final _movieDetailSubject = BehaviorSubject<Movie>();
  final _searchMoviesSubject = BehaviorSubject<List<Movie>>();

  Stream<List<Movie>> get nowShowingMoviesStream => _nowShowingMoviesSubject.stream;
  Stream<List<Movie>> get popularMoviesStream => _popularMoviesSubject.stream;
  Stream<List<Movie>> get upcomingMoviesStream => _upcomingMoviesSubject.stream;
  Stream<Movie> get movieDetailStream => _movieDetailSubject.stream;
  Stream<List<Movie>> get searchMoviesStream => _searchMoviesSubject.stream;

  // Helper function to build query parameters for better readability
  Uri buildUri(String baseUrl, Map<String, String> queryParams) {
    return Uri.parse(baseUrl).replace(queryParameters: queryParams);
  }

  Future<void> getNowShowingMovies() async {
    final queryParams = {
      'api_key': apiKey,
      'with_genres': '16',
      'primary_release_date.gte': '2023-01-01',
    };

    Uri url = buildUri('https://api.themoviedb.org/3/discover/movie', queryParams);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['results'];
        List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
        _nowShowingMoviesSubject.add(movies);
      } else {
        _nowShowingMoviesSubject.addError("Failed to load data: ${response.body}");
      }
    } catch (e) {
      _nowShowingMoviesSubject.addError("Error fetching now showing movies: $e");
    }
  }

  // Function to fetch Popular Animation Movies and emit to the stream
  Future<void> getPopularMovies() async {
    final queryParams = {
      'api_key': apiKey,
      'with_genres': '16',
      'sort_by': 'popularity.desc',
    };

    Uri url = buildUri('https://api.themoviedb.org/3/discover/movie', queryParams);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['results'];
        List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
        _popularMoviesSubject.add(movies);
      } else {
        _popularMoviesSubject.addError("Failed to load data: ${response.body}");
      }
    } catch (e) {
      _popularMoviesSubject.addError("Error fetching popular movies: $e");
    }
  }

  // Function to fetch Upcoming Movies and emit to the stream
  Future<void> getUpcomingMovies() async {
    final queryParams = {
      'api_key': apiKey,
      'with_genres': '16',
      'primary_release_date.gte': '2024-10-01',
      'sort_by': 'release_date.asc',
    };

    Uri url = buildUri('https://api.themoviedb.org/3/discover/movie', queryParams);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['results'];
        List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
        _upcomingMoviesSubject.add(movies);
      } else {
        _upcomingMoviesSubject.addError("Failed to load data: ${response.body}");
      }
    } catch (e) {
      _upcomingMoviesSubject.addError("Error fetching upcoming movies: $e");
    }
  }

  // Fetch Detailed Movie Info by Movie ID and emit to the stream
  Future<void> getMovieDetail(int movieId) async {
    Uri url = Uri.parse("https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        Movie movie = Movie.fromMap(data);
        _movieDetailSubject.add(movie);
      } else {
        _movieDetailSubject.addError("Failed to load movie details: ${response.body}");
      }
    } catch (e) {
      _movieDetailSubject.addError("Error fetching movie details: $e");
    }
  }

  // Function to search for movies with RxDart
  Future<void> searchMovies(String query) async {
    final queryParams = {
      'api_key': apiKey,
      'query': query,
      'with_genres': '16',
    };

    Uri url = buildUri('https://api.themoviedb.org/3/search/movie', queryParams);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['results'];
        List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
        _searchMoviesSubject.add(movies);
      } else {
        _searchMoviesSubject.addError("Failed to load search results: ${response.body}");
      }
    } catch (e) {
      _searchMoviesSubject.addError("Error fetching search results: $e");
    }
  }

  // Dispose of the BehaviorSubjects to avoid memory leaks
  void dispose() {
    _nowShowingMoviesSubject.close();
    _popularMoviesSubject.close();
    _upcomingMoviesSubject.close();
    _movieDetailSubject.close();
    _searchMoviesSubject.close();
  }
}
