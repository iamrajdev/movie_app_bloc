import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/domain/usecases/search_movies.dart';
import 'package:movie_app_bloc/presentation/bloc/search_movies/search_movies_event.dart';
import 'package:movie_app_bloc/presentation/bloc/search_movies/search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;

  SearchMoviesBloc({required this.searchMovies})
      : super(SearchMoviesInitial()) {
    on<FetchSearchMovies>((event, emit) async {
      emit(SearchMoviesLoading());
      final failureOrMovies = await searchMovies(event.query);
      failureOrMovies.fold(
        (failure) => emit(SearchMoviesErrors(failure.toString())),
        (movies) => emit(SearchMoviesLoaded(movies)),
      );
    });
  }
}
