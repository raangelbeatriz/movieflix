import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/movie_flix.dart';
import 'app/repository/movie_repository.dart';
import 'app/repository/movie_repository_impl.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<MovieRepository>(create: (context) => MovieRepositoryImpl()),
      ],
      child: const MovieFlix(),
    ),
  );
}
