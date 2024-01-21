import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_bloc/domain/entities/movie.dart';
import 'package:movie_app_bloc/domain/usecases/get_trending_movies.dart';

import 'get_trending_movies_test.mocks.dart';

// @GenerateNiceMocks([MockSpec<MovieRepository>()])

void main() {
  late GetTrendingMovies useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = GetTrendingMovies(movieRepository: mockMovieRepository);
  });

  final tMovieList = [
    Movie(id: 1, title: 'title', overview: 'overview', posterPath: '/image'),
    Movie(id: 2, title: 'title2', overview: 'overview2', posterPath: '/image')
  ];

  test('Should get trending movies from the repository', () async {
    //Arrange
    when(mockMovieRepository.getTrendingMovies())
        .thenAnswer((_) async => tMovieList);

    //Act
    final result = await useCase();

    //Assert
    expect(result, tMovieList);
    verify(mockMovieRepository.getTrendingMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
