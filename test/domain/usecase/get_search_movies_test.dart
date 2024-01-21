import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_bloc/domain/entities/movie.dart';
import 'package:movie_app_bloc/domain/repositories/movie_repository.dart';
import 'package:movie_app_bloc/domain/usecases/search_movies.dart';

import 'get_popular_movies_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
void main() {
  late SearchMovies useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = SearchMovies(movieRepository: mockMovieRepository);
  });
  const String tQuery = 'Lift';

  final tMovieList = [
    Movie(id: 1, title: 'title', overview: 'overview', posterPath: '/image'),
    Movie(id: 2, title: 'title2', overview: 'overview2', posterPath: '/image')
  ];

  test('Should get search movies from the repository', () async {
    //Arrange
    when(mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((realInvocation) async => tMovieList);

    //Act
    final result = await useCase(tQuery);

    //Assert
    expect(result, tMovieList);
    verify(mockMovieRepository.searchMovies(tQuery));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
