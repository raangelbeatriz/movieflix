import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieflix/app/constants.dart';

import 'core/Routes/routes.dart';
import 'screens/Home Page/home_page_router.dart';
import 'screens/Movie Details/movie_page_router.dart';
import 'screens/Movie Search/search_movie_router.dart';

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
