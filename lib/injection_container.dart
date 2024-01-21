import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_bloc/data/datasources/movie_remote_datasource.dart';
import 'package:movie_app_bloc/data/datasources/remote/movie_remote_datasource_impl.dart';
import 'package:movie_app_bloc/data/repositories/movie_repository_impl.dart';
import 'package:movie_app_bloc/domain/repositories/movie_repository.dart';
import 'package:movie_app_bloc/domain/usecases/get_popular_movies.dart';
import 'package:movie_app_bloc/domain/usecases/get_trending_movies.dart';
import 'package:movie_app_bloc/domain/usecases/search_movies.dart';
import 'package:movie_app_bloc/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie_app_bloc/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie_app_bloc/presentation/bloc/trending_movies/trending_movies_bloc.dart';

final it = GetIt.instance;

void init() {
  // Bloc
  it.registerFactory(() => TrendingMoviesBloc(getTrendingMovies: it()));
  it.registerFactory(() => PopularMoviesBloc(getPopularMovies: it()));
  it.registerFactory(() => SearchMoviesBloc(searchMovies: it()));

  // Use Cases
  it.registerLazySingleton(() => GetPopularMovies(movieRepository: it()));
  it.registerLazySingleton(() => GetTrendingMovies(movieRepository: it()));
  it.registerLazySingleton(() => SearchMovies(movieRepository: it()));

  // Repositories
  it.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(remoteDataSource: it()));

  // Data Sources
  it.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: it()));

  // Http Client
  it.registerLazySingleton(() => http.Client());
}
