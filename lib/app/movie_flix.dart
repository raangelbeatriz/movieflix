import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieflix/app/constants.dart';

import 'core/routes/routes.dart';
import 'screens/home/home_page_router.dart';
import 'screens/moviedetails/movie_details_router.dart';
import 'screens/moviesearch/search_movie_router.dart';

class MovieFlix extends StatelessWidget {
  const MovieFlix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        backgroundColor: kbackgroundColor,
        scaffoldBackgroundColor: kbackgroundColor,
        secondaryHeaderColor: ksecondColor,
        textTheme:
            GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.white),
      ),
      routes: {
        Routes.home: (_) => HomePageRouter.page,
        Routes.searchMovies: (_) => SearchMovieRouter.page,
        Routes.movieDetails: (_) => MovieDetailsRouter.page
      },
    );
  }
}
