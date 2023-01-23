import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'app/constants.dart';
import 'app/core/Routes/routes.dart';
import 'app/repository/movie_repository.dart';
import 'app/repository/movie_repository_impl.dart';
import 'app/screens/Home Page/home_page.dart';
import 'app/screens/Home Page/home_view_model.dart';
import 'app/screens/Movie Details/movie_details_view_model.dart';
import 'app/screens/Movie Search/search_movies.dart';
import 'app/screens/Movie Search/search_movies_view_model.dart';

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
