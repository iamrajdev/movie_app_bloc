import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/injection_container.dart';
import 'package:movie_app_bloc/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie_app_bloc/presentation/bloc/popular_movies/popular_movies_event.dart';
import 'package:movie_app_bloc/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie_app_bloc/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movie_app_bloc/presentation/bloc/trending_movies/trending_movies_event.dart';
import 'package:movie_app_bloc/presentation/pages/home.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App Bloc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) =>
                it<PopularMoviesBloc>()..add(FetchPopularMovies())),
        BlocProvider(
            create: (context) =>
                it<TrendingMoviesBloc>()..add(FetchTrendingMovies())),
        BlocProvider(create: (context) => it<SearchMoviesBloc>()),
      ], child: const HomeScreen()),
    );
  }
}
