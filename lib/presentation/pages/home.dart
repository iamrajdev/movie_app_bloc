import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/domain/entities/movie.dart';
import 'package:movie_app_bloc/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie_app_bloc/presentation/bloc/popular_movies/popular_movies_state.dart';
import 'package:movie_app_bloc/presentation/widgets/movie_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
      ),
      body: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
        if (state is PopularMoviesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PopularMoviesLoaded) {
          return MovieList(movies: state.movies);
        } else if (state is PopularMoviesErrors) {
          return Center(
            child: Text(state.message),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  const MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(movie);
      },
    );
  }
}
