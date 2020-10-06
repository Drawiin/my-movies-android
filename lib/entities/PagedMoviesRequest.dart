import 'package:my_movies_app/entities/Movie.dart';

class PagedMoviesRequest {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<Movie> results;

  PagedMoviesRequest(
  {this.page = 1, this.totalResults = 0, this.totalPages = 1, this.results: const <Movie>[]});

  PagedMoviesRequest.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        totalResults = json['total_results'],
        totalPages = json['total_pages'],
        results =
            (json['results'] as List).map((e) => Movie.fromJson(e)).toList();
}
