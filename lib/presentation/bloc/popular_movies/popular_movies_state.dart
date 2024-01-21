import 'package:movie_app_bloc/domain/entities/movie.dart';

abstract class PopularMoviesState {}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesLoaded extends PopularMoviesState {
  final List<Movie> movies;
  PopularMoviesLoaded(this.movies);
}

class PopularMoviesErrors extends PopularMoviesState {
  final String message;

  PopularMoviesErrors(this.message);
}
