import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:movieflix/models/movie_details_model.dart';
import 'package:movieflix/repository/movie_repository.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;
  MovieDetailsModel movie = MovieDetailsModel();

  MovieDetailsViewModel({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  Future<MovieDetailsModel> fetchMovieDetail(String id) async {
    movie = await _movieRepository.getMovie(id);
    return movie;
  }

  String dateFormater(DateTime? date) {
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = "";
    if (date != null) {
      formattedDate = formatter.format(date);
    }
    return formattedDate;
  }
}
