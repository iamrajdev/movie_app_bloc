import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/domain/usecases/get_popular_movies.dart';
import 'package:movie_app_bloc/presentation/bloc/popular_movies/popular_movies_event.dart';
import 'package:movie_app_bloc/presentation/bloc/popular_movies/popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({required this.getPopularMovies})
      : super(PopularMoviesInitial()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());
      final failureOrMovies = await getPopularMovies();
      failureOrMovies.fold(
        (failure) => emit(PopularMoviesErrors(failure.toString())),
        (movies) => emit(PopularMoviesLoaded(movies)),
      );
    });
  }
}
