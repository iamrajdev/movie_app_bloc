import 'package:flutter/material.dart';
import 'package:movie_app_bloc/core/constants/constants.dart';
import 'package:movie_app_bloc/domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard(this.movie, {super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Ink.image(
          image: NetworkImage('${Constants.IMAGE_URL}${movie.posterPath}'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
