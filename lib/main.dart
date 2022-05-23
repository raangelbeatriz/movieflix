import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieflix/constants.dart';
import 'package:movieflix/screens/Home%20Page/home_page.dart';
import 'package:movieflix/screens/Movie%20Search/search_movies.dart';
import 'package:movieflix/screens/Home%20Page/home_page_viewmodel.dart';
import 'package:movieflix/screens/Movie%20Search/search_movies_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomePageViewModel>(
          create: (context) => HomePageViewModel(),
        ),
        ChangeNotifierProvider<SearchMoviesViewModel>(
          create: (context) => SearchMoviesViewModel(),
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
        '/homePage': (_) => const HomePage(),
        '/searchMovies': (_) => const SearchMoviesPage(),
      },
    );
  }
}
