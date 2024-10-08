import 'package:otaku_movie_app/models/model_genre.dart';
import 'package:otaku_movie_app/models/model_production.dart';

class Movie {
  final String? title;
  final String? backDropPath;
  final double? voteAverage; // Add voteAverage to store movie rating

  final String? description; // Overview
  final String? posterPath; // Poster path
  final List<Genre>? genres; // List of genres
  final String? releaseDate; // Release date
  final int? runtime; // Runtime in minutes
  final String? originalLanguage; // Language of the movie
  final String? rating; // Custom rating field if needed
  final List<ProductionCompany>? productionCompanies; // List of production companies

  Movie({required this.title, required this.backDropPath, required this.voteAverage, required this.description, required this.posterPath, required this.genres, required this.releaseDate, required this.runtime, required this.originalLanguage, required this.rating, required this.productionCompanies});

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? 'No Title Available',
      backDropPath: map['backdrop_path'],
      voteAverage: (map['vote_average'] as num?)?.toDouble(), // Convert vote_average to double
      description: map['overview'] ?? 'No description available',
      posterPath: map['poster_path'],
      genres: (map['genres'] as List<dynamic>?)?.map((genre) => Genre.fromMap(genre)).toList(),
      releaseDate: map['release_date'],
      runtime: map['runtime'],
      originalLanguage: map['original_language'],
      rating: map['rating'] ?? 'Not Rated',
      productionCompanies: (map['production_companies'] as List<dynamic>?)?.map((company) => ProductionCompany.fromMap(company)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'backDropPath': backDropPath,
      'voteAverage': voteAverage,
      'overview': description,
      'poster_path': posterPath,
      'genres': genres?.map((genre) => genre.toMap()).toList(),
      'release_date': releaseDate,
      'runtime': runtime,
      'original_language': originalLanguage,
      'rating': rating,
      'production_companies': productionCompanies?.map((company) => company.toMap()).toList(),
    };
  }
}
