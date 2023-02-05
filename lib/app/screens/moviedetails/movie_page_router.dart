import 'package:flutter/material.dart';
import 'package:movieflix/app/screens/moviedetails/movie_details.dart';
import 'package:provider/provider.dart';

import 'movie_details_view_model.dart';

class MovieDetailsRouter {
  MovieDetailsRouter._();
  static Widget get page => MultiProvider(
        providers: [
          ChangeNotifierProvider<MovieDetailsViewModel>(
            create: (context) =>
                MovieDetailsViewModel(movieRepository: context.read()),
          ),
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments as int;
          return MovieDetailsPage(id: args);
        },
      );
}
