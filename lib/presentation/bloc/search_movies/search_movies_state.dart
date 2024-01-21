import 'package:movie_app_bloc/domain/entities/movie.dart';

abstract class SearchMoviesState {}

class SearchMoviesInitial extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesLoaded extends SearchMoviesState {
  final List<Movie> movies;
  SearchMoviesLoaded(this.movies);
}

class SearchMoviesErrors extends SearchMoviesState {
  final String message;

  SearchMoviesErrors(this.message);
}
