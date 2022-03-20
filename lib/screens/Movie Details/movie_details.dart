import 'package:flutter/material.dart';
import 'package:movieflix/components/super_poster.dart';
import 'package:movieflix/components/synopis_widget.dart';
import 'package:movieflix/models/movie_details_model.dart';
import 'package:movieflix/screens/Movie%20Details/movie_details_viewmodel.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final MovieDetailsViewModel movieDetailsViewModel = MovieDetailsViewModel();
  @override
  void initState() {
    movieDetailsViewModel.fetchMovieDetail(widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.65,
              child: FutureBuilder<MovieDetailsModel>(
                future: movieDetailsViewModel
                    .fetchMovieDetail(widget.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      String date = movieDetailsViewModel.dateFormater(
                          movieDetailsViewModel.movie.releaseDate!);
                      return SuperPosterWidget(
                        ranking: movieDetailsViewModel.movie.voteAverage,
                        releaseDate: date,
                        posterPath: movieDetailsViewModel.movie.posterPath,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Container(
              height: size.height * 0.35,
              child: FutureBuilder<MovieDetailsModel>(
                future: movieDetailsViewModel
                    .fetchMovieDetail(widget.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: SynopsisWidget(
                        text: movieDetailsViewModel.movie.overview,
                        movieTitle: movieDetailsViewModel.movie.title,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
