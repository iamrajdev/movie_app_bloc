import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_bloc/core/constants/constants.dart';
import 'package:movie_app_bloc/core/errors/server_exception.dart';
import 'package:movie_app_bloc/data/datasources/movie_remote_datasource.dart';
import 'package:movie_app_bloc/data/datasources/remote/movie_remote_datasource_impl.dart';

import 'movie_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MovieRemoteDataSource dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  const String sampleApiResponse = '''
{
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/path.jpg",
      "id": 1,
      "title": "Sample Movie",
      "original_language": "en",
      "original_title": "Sample Movie",
      "overview": "Overview here",
      "poster_path": "/path2.jpg",
      "media_type": "movie",
      "genre_ids": [1, 2, 3],
      "popularity": 100.0,
      "release_date": "2020-01-01",
      "video": false,
      "vote_average": 7.5,
      "vote_count": 100
    }
  ],
  "total_pages": 1,
  "total_results": 1
}
''';

  const tQuery = 'Life';

  const tUrl =
      '${Constants.BASE_URL}/trending/movie/day?api_key=${Constants.API_KEY}';
  const pUrl =
      '${Constants.BASE_URL}/movie/popular?api_key=${Constants.API_KEY}';
  const sUrl =
      '${Constants.BASE_URL}/search/movie?query=$tQuery&api_key=${Constants.API_KEY}';

  test('Should perform a GET request on a url to get trending movies',
      () async {
    // Arrange
    when(mockHttpClient.get(Uri.parse(tUrl)))
        .thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    // Act
    await dataSource.getTrendingMovies();

    // Asserts
    verify(mockHttpClient.get(Uri.parse(tUrl)));
  });

  test('Should perform a GET request on a url to get popular movies', () async {
    // Arrange
    when(mockHttpClient.get(Uri.parse(pUrl)))
        .thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    // Act
    await dataSource.getPopularMovies();

    // Asserts
    verify(mockHttpClient.get(Uri.parse(pUrl)));
  });

  test('Should perform a GET request on a url to get search movies', () async {
    // Arrange
    when(mockHttpClient.get(Uri.parse(sUrl)))
        .thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    // Act
    await dataSource.searchMovies(tQuery);

    // Asserts
    verify(mockHttpClient.get(Uri.parse(sUrl)));
  });

  test('Should throw a ServerException when response code is 404', () async {
    // Arrange
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));

    // Act
    final call = dataSource.getTrendingMovies;

    // Asserts
    expect(() => call(), throwsA(isA<ServerException>()));
  });
}
