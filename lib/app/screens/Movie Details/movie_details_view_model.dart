import 'package:flutter/cupertino.dart';

import '../../models/movie_details_model.dart';
import '../../repository/movie_repository.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;
  MovieDetailsModel? movie;
  bool isLoading = true;

  MovieDetailsViewModel({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  Future<void> fetchMovieDetail(String id) async {
    isLoading = true;
    movie = await _movieRepository.getMovie(id);
    isLoading = false;
    notifyListeners();
  }
}
