import 'package:flutter/cupertino.dart';

import '../../models/movie_details_model.dart';
import '../../repository/movie_repository.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;
  MovieDetailsModel movie = MovieDetailsModel();

  MovieDetailsViewModel({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  Future<MovieDetailsModel> fetchMovieDetail(String id) async {
    movie = await _movieRepository.getMovie(id);
    return movie;
  }
}
