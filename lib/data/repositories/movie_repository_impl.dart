import 'package:movie_app_bloc/data/datasources/movie_remote_datasource.dart';
import 'package:movie_app_bloc/data/models/movie_model.dart';
import 'package:movie_app_bloc/domain/entities/movie.dart';
import 'package:movie_app_bloc/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Movie>> getPopularMovies() async {
    final List<MovieModel> moviesModel =
        await remoteDataSource.getPopularMovies();
    final List<Movie> movies =
        moviesModel.map((movie) => movie.toEntity()).toList();
    return movies;
  }

  @override
  Future<List<Movie>> getTrendingMovies() async {
    final List<MovieModel> moviesModel =
        await remoteDataSource.getTrendingMovies();
    final List<Movie> movies =
        moviesModel.map((movie) => movie.toEntity()).toList();
    return movies;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    final List<MovieModel> moviesModel =
        await remoteDataSource.searchMovies(query);
    final List<Movie> movies =
        moviesModel.map((movie) => movie.toEntity()).toList();
    return movies;
  }
}
