import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_bloc/domain/entities/movie.dart';
import 'package:movie_app_bloc/domain/repositories/movie_repository.dart';
import 'package:movie_app_bloc/domain/usecases/get_popular_movies.dart';

import 'get_popular_movies_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
void main() {
  late GetPopularMovies useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = GetPopularMovies(movieRepository: mockMovieRepository);
  });

  final tMovieList = [
    Movie(id: 1, title: 'title', overview: 'overview', posterPath: '/image'),
    Movie(id: 2, title: 'title2', overview: 'overview2', posterPath: '/image')
  ];

  test('Should get popular movies from the repository', () async {
    //Arrange
    when(mockMovieRepository.getPopularMovies())
        .thenAnswer((_) async => tMovieList);

    //Act
    final result = await useCase();

    //Assert
    expect(result, tMovieList);
    verify(mockMovieRepository.getPopularMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
