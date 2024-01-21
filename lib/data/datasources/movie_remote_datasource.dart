import 'package:movie_app_bloc/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTrendingMovies();
  Future<List<MovieModel>> searchMovies(String query);
}
  