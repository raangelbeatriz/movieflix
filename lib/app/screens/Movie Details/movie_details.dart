import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/formatters/formatters.dart';
import '../../core/components/super_poster.dart';
import '../../core/components/synopis_widget.dart';
import 'movie_details_view_model.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late MovieDetailsViewModel movieDetailsViewModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      movieDetailsViewModel = context.read<MovieDetailsViewModel>();
      movieDetailsViewModel.fetchMovieDetail(widget.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<MovieDetailsViewModel>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          String date = Formatters.dateFormater(
              movieDetailsViewModel.movie?.releaseDate!);
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.65,
                  child: SuperPosterWidget(
                    ranking: movieDetailsViewModel.movie!.voteAverage,
                    releaseDate: date,
                    posterPath: movieDetailsViewModel.movie!.posterPath,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.35,
                  child: SynopsisWidget(
                    text: movieDetailsViewModel.movie!.overview,
                    movieTitle: movieDetailsViewModel.movie!.title,
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
