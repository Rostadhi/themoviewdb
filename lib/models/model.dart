import 'model_genre.dart';
import 'model_production.dart';

class Movie {
  final String? title;
  final String? backDropPath;
  final double? voteAverage;
  final String? description;
  final String? posterPath;
  final List<Genre>? genres; // List of full genre objects (optional)
  final List<int>? genreIds; // Store genre IDs from API response
  final String? releaseDate;
  final int? runtime;
  final String? originalLanguage;
  final String? rating;
  final double? popularity;
  final List<ProductionCompany>? productionCompanies;

  Movie({
    required this.title,
    required this.backDropPath,
    required this.voteAverage,
    required this.description,
    required this.posterPath,
    required this.genres,
    required this.genreIds,
    required this.releaseDate,
    required this.runtime,
    required this.originalLanguage,
    required this.rating,
    required this.popularity,
    required this.productionCompanies,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? 'No Title Available',
      backDropPath: map['backdrop_path'],
      voteAverage: (map['vote_average'] as num?)?.toDouble(),
      description: map['overview'] ?? 'No description available',
      posterPath: map['poster_path'],
      genres: (map['genres'] as List<dynamic>?)?.map((genre) => Genre.fromMap(genre)).toList(),
      genreIds: List<int>.from(map['genre_ids'] ?? []), // Store genre IDs
      releaseDate: map['release_date'],
      runtime: map['runtime'],
      originalLanguage: map['original_language'],
      rating: map['rating'] ?? 'Not Rated',
      popularity: (map['popularity'] as num?)?.toDouble(),
      productionCompanies: (map['production_companies'] as List<dynamic>?)?.map((company) => ProductionCompany.fromMap(company)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'backDropPath': backDropPath,
      'voteAverage': voteAverage,
      'overview': description, // Must match the column name 'overview'
      'poster_path': posterPath, // Must match the column name 'poster_path'
      'genreIds': genreIds?.join(','), // Convert list to a comma-separated string
      'releaseDate': releaseDate,
      'runtime': runtime,
      'originalLanguage': originalLanguage,
      'rating': rating,
      'popularity': popularity,
    };
  }
}
