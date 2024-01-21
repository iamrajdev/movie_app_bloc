import 'package:dartz/dartz.dart';
import 'package:movie_app_bloc/core/errors/server_exception.dart';
import 'package:movie_app_bloc/core/errors/server_failure.dart';
import 'package:movie_app_bloc/data/datasources/movie_remote_datasource.dart';
import 'package:movie_app_bloc/data/models/movie_model.dart';
import 'package:movie_app_bloc/domain/entities/movie.dart';
import 'package:movie_app_bloc/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerFailure, List<Movie>>> getPopularMovies() async {
    try {
      final List<MovieModel> moviesModel =
          await remoteDataSource.getPopularMovies();
      final List<Movie> movies =
          moviesModel.map((movie) => movie.toEntity()).toList();
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, List<Movie>>> getTrendingMovies() async {
    try {
      final List<MovieModel> moviesModel =
          await remoteDataSource.getTrendingMovies();
      final List<Movie> movies =
          moviesModel.map((movie) => movie.toEntity()).toList();
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, List<Movie>>> searchMovies(String query) async {
    try {
      final List<MovieModel> moviesModel =
          await remoteDataSource.searchMovies(query);
      final List<Movie> movies =
          moviesModel.map((movie) => movie.toEntity()).toList();
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
