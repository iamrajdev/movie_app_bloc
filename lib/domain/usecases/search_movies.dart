import 'package:dartz/dartz.dart';
import 'package:movie_app_bloc/core/errors/server_failure.dart';
import 'package:movie_app_bloc/domain/entities/movie.dart';
import 'package:movie_app_bloc/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository movieRepository;

  SearchMovies({required this.movieRepository});

  Future<Either<Failure, List<Movie>>> call(String query) async {
    return await movieRepository.searchMovies(query);
  }
}
