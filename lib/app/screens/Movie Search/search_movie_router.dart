import 'package:flutter/material.dart';
import 'package:movieflix/app/screens/Movie%20Search/search_movies.dart';
import 'package:movieflix/app/screens/Movie%20Search/search_movies_view_model.dart';
import 'package:provider/provider.dart';

class SearchMovieRouter {
  SearchMovieRouter._();
  static Widget get page => MultiProvider(
        providers: [
          ChangeNotifierProvider<SearchMoviesViewModel>(
            create: (context) =>
                SearchMoviesViewModel(movieRepository: context.read()),
          ),
        ],
        child: const SearchMoviesPage(),
      );
}
