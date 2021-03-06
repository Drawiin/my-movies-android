import 'dart:convert';

class Movie {
  final int id;
  final String title;
  final String releaseDate;
  final double voteAverage;
  final String backdropPath;
  final String overview;

  Movie(this.id, this.title, this.releaseDate, this.voteAverage,
      this.backdropPath, this.overview);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        releaseDate = json['release_date'],
        voteAverage = json['vote_average'].toDouble(),
        backdropPath = json['backdrop_path'],
        overview = json['overview'];

  String toJson() {
    return jsonEncode({
      "id": id,
      "title": title,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'backdrop_path': backdropPath,
      'overview': overview
    });
  }
}
