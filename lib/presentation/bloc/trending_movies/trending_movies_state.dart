import 'package:movie_app_bloc/domain/entities/movie.dart';

abstract class TrendingMoviesState {}

class TrendingMoviesInitial extends TrendingMoviesState {}

class TrendingMoviesLoading extends TrendingMoviesState {}

class TrendingMoviesLoaded extends TrendingMoviesState {
  final List<Movie> movies;
  TrendingMoviesLoaded(this.movies);
}

class TrendingMoviesErrors extends TrendingMoviesState {
  final String message;

  TrendingMoviesErrors(this.message);
}
