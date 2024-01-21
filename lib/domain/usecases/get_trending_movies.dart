import 'package:movie_app_bloc/domain/entities/movie.dart';
import 'package:movie_app_bloc/domain/repositories/movie_repository.dart';

class GetTrendingMovies {
  final MovieRepository movieRepository;

  GetTrendingMovies({required this.movieRepository});

  Future<List<Movie>> call() async {
    return await movieRepository.getTrendingMovies();
  }
}
