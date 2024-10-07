class Movie {
  final String? title;
  final String? backDropPath;
  final double? voteAverage; // Add voteAverage to store movie rating

  Movie({
    required this.title,
    required this.backDropPath,
    required this.voteAverage,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? 'No Title Available',
      backDropPath: map['backdrop_path'],
      voteAverage: (map['vote_average'] as num?)?.toDouble(), // Convert vote_average to double
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'backDropPath': backDropPath,
      'voteAverage': voteAverage
    };
  }
}
