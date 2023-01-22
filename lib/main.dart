import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieflix/constants.dart';
import 'package:movieflix/repository/movie_repository.dart';
import 'package:movieflix/repository/movie_repository_impl.dart';
import 'package:movieflix/screens/Home%20Page/home_page.dart';
import 'package:movieflix/screens/Movie%20Details/movie_details_view_model.dart';
import 'package:movieflix/screens/Movie%20Search/search_movies.dart';
import 'package:movieflix/screens/Home%20Page/home_view_model.dart';
import 'package:movieflix/screens/Movie%20Search/search_movies_view_model.dart';
import 'package:provider/provider.dart';

import 'core/Routes/routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<MovieRepository>(create: (context) => MovieRepositoryImpl()),
        ChangeNotifierProvider<HomePageViewModel>(
          create: (context) =>
              HomePageViewModel(movieRepository: context.read()),
        ),
        ChangeNotifierProvider<SearchMoviesViewModel>(
          create: (context) =>
              SearchMoviesViewModel(movieRepository: context.read()),
        ),
        ChangeNotifierProvider<MovieDetailsViewModel>(
          create: (context) =>
              MovieDetailsViewModel(movieRepository: context.read()),
        ),
      ],
      child: const MovieFlix(),
    ),
  );
}

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
      home: const Scaffold(
        body: HomePage(),
      ),
      routes: <String, WidgetBuilder>{
        Routes.home: (_) => const HomePage(),
        Routes.searchMovies: (_) => const SearchMoviesPage(),
      },
    );
  }
}
