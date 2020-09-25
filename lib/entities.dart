class PopularMovies {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<Movie> results;

  PopularMovies(this.page, this.totalResults, this.totalPages, this.results);

  PopularMovies.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        totalResults = json['total_results'],
        totalPages = json['total_pages'],
        results =
        (json['results'] as List).map((e) => Movie.fromJson(e)).toList();
}

class Movie {
  final int id;
  final String title;
  final String releaseDate;
  final double voteAverage;
  final String backdropPath;

  Movie(this.id, this.title, this.releaseDate, this.voteAverage,
      this.backdropPath);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        releaseDate = json['release_date'],
        voteAverage = json['vote_average'].toDouble(),
        backdropPath = json['backdrop_path'];
}