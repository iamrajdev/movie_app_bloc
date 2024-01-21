import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app_bloc/core/constants/constants.dart';
import 'package:movie_app_bloc/core/errors/server_exception.dart';
import 'package:movie_app_bloc/data/datasources/movie_remote_datasource.dart';
import 'package:movie_app_bloc/data/models/movie_model.dart';

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;
  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client.get(Uri.parse(
        '${Constants.BASE_URL}/movie/popular?api_key=${Constants.API_KEY}'));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> movies = (responseBody['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();

      return movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    final response = await client.get(Uri.parse(
        '${Constants.BASE_URL}/trending/movie/day?api_key=${Constants.API_KEY}'));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> movies = (responseBody['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();

      return movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client.get(Uri.parse(
        '${Constants.BASE_URL}/search/movie?query=$query&api_key=${Constants.API_KEY}'));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> movies = (responseBody['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
      return movies;
    } else {
      throw ServerException();
    }
  }
}
