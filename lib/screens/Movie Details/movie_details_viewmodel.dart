import 'package:intl/intl.dart';
import 'package:movieflix/models/movie_details_model.dart';
import 'package:movieflix/services/request_helper.dart';

class MovieDetailsViewModel {
  MovieDetailsModel movie = MovieDetailsModel();

  Future<MovieDetailsModel> fetchMovieDetail(String id) async {
    movie = await RequestHelper().getMovie(id);
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
