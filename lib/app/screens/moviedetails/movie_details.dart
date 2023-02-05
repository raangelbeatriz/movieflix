import 'package:flutter/material.dart';
import 'package:movieflix/app/core/components/go_back_widget.dart';
import 'package:movieflix/app/core/ui/helpers/messages.dart';
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

class _MovieDetailsPageState extends State<MovieDetailsPage> with Messages {
  late MovieDetailsViewModel movieDetailsViewModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      movieDetailsViewModel = context.read<MovieDetailsViewModel>();
      movieDetailsViewModel.addListener(() {
        if (movieDetailsViewModel.errorMessage.isNotEmpty) {
          showError(movieDetailsViewModel.errorMessage);
        }
      });
      movieDetailsViewModel.fetchMovieDetail(widget.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const GoBackWidget(),
      ),
      body: Consumer<MovieDetailsViewModel>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (value.movie != null) {
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
                  SynopsisWidget(
                    text: movieDetailsViewModel.movie!.overview,
                    movieTitle: movieDetailsViewModel.movie!.title,
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('ERROR WHILE GETTING MOVIE'),
            );
          }
        }
      }),
    );
  }
}
