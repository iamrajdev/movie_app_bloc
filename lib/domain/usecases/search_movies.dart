import 'package:movie_app_bloc/domain/entities/movie.dart';
import 'package:movie_app_bloc/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository movieRepository;

  SearchMovies({required this.movieRepository});

  Future<List<Movie>> call(String query) async {
    return await movieRepository.searchMovies(query);
  }
}
