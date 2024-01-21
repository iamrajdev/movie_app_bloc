import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_bloc/data/datasources/movie_remote_datasource.dart';
import 'package:movie_app_bloc/data/models/movie_model.dart';
import 'package:movie_app_bloc/data/repositories/movie_repository_impl.dart';
import 'package:movie_app_bloc/domain/entities/movie.dart';

import 'movie_repositories_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRemoteDataSource>()])

//Run
void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    repository =
        MovieRepositoryImpl(remoteDataSource: mockMovieRemoteDataSource);
  });

  const String tQuery = 'Life';

  final tMovieModelList = [
    MovieModel(
      id: 1,
      title: 'title',
      overview: 'overview',
      posterPath: '/image',
    ),
    MovieModel(
      id: 2,
      title: 'title2',
      overview: 'overview2',
      posterPath: '/image',
    )
  ];

  final tMovieList = [
    const Movie(
      id: 1,
      title: 'title',
      overview: 'overview',
      posterPath: '/image',
    ),
    const Movie(
      id: 2,
      title: 'title2',
      overview: 'overview2',
      posterPath: '/image',
    )
  ];

  test('Should get trending movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.getTrendingMovies())
        .thenAnswer((_) async => tMovieModelList);

    final result = await repository.getTrendingMovies();

    verify(mockMovieRemoteDataSource.getTrendingMovies());

    expect(result, equals(tMovieList));
  });

  test('Should get popular movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.getPopularMovies())
        .thenAnswer((_) async => tMovieModelList);

    final result = await repository.getPopularMovies();

    verify(mockMovieRemoteDataSource.getPopularMovies());

    expect(result, equals(tMovieList));
  });

  test('Should get search movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.searchMovies(tQuery))
        .thenAnswer((_) async => tMovieModelList);

    final result = await repository.searchMovies(tQuery);

    verify(mockMovieRemoteDataSource.searchMovies(tQuery));
    expect(result, equals(tMovieList));
  });
}
