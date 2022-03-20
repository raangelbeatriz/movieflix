import 'package:movieflix/models/movie_details_model.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/models/page_model.dart';
import 'package:movieflix/services/networking.dart';

import '../constants.dart';

class RequestHelper {
  int _totalPage = 0;
  int _totalPageSearch = 0;

  Future<List<Movie>> searchMovie(String movie, int pageNumber) async {
    List<Movie> movies = [];
    try {
      NetworkHelper networkHelper = NetworkHelper(
          '$openMovieURL/search/movie?api_key=d023c237ec71d6a50e32e635042fb18f&language=en-US&query=$movie&page=$pageNumber&include_adult=false');

      var moviesData = await networkHelper.getData();
      Map<String, dynamic> response = moviesData;
      List<dynamic> result = response["results"];
      for (int i = 0; i < result.length; i++) {
        movies.add(Movie.fromJson(result[i]));
      }
    } catch (e) {
      Exception(e);
    }
    return movies;
  }

  Future<List<Movie>> getTopMovies(int pageNumber) async {
    List<Movie> movies = [];

    NetworkHelper networkHelper = NetworkHelper(
        '$openMovieURL/movie/popular?api_key=d023c237ec71d6a50e32e635042fb18f&language=en-US&page=$pageNumber');

    var moviesData = await networkHelper.getData();
    Map<String, dynamic> response = moviesData;
    List<dynamic> result = response["results"];
    result.forEach((element) => movies.add(Movie.fromJson(element)));
    _totalPage = response["total_pages"];
    return movies;
  }

  Future<int> getTotalPagesSearchMovies(String movie) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openMovieURL/search/movie?api_key=d023c237ec71d6a50e32e635042fb18f&language=en-US&query=$movie&page=1&include_adult=false');

    var moviesData = await networkHelper.getData();
    Map<String, dynamic> response = moviesData;
    _totalPageSearch = response["total_pages"];
    print("Total pages = $_totalPageSearch");
    return _totalPageSearch;
  }

  Future<int> getTotalPagesTopMovie() async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openMovieURL/movie/popular?api_key=d023c237ec71d6a50e32e635042fb18f&language=en-US&page=1');

    var moviesData = await networkHelper.getData();
    Map<String, dynamic> response = moviesData;
    _totalPage = response["total_pages"];
    print("Total Pages $_totalPageSearch");
    return _totalPage;
  }

  Future<MovieDetailsModel> getMovie(String id) async {
    MovieDetailsModel movie = MovieDetailsModel();
    NetworkHelper networkHelper =
        NetworkHelper('$openMovieURL/movie/$id?api_key=$apiKey&language=en-US');
    var moviesData = await networkHelper.getData();
    Map<String, dynamic> response = moviesData;
    movie = MovieDetailsModel.fromJson(response);
    print(movie.title);
    return movie;
  }

  Future<List<Movie>> getUpcomingMovies() async {
    print("request");
    List<Movie> movies = [];
    NetworkHelper networkHelper = NetworkHelper(
        '$openMovieURL/movie/upcoming?api_key=$apiKey&language=en-US&page=1');

    var moviesData = await networkHelper.getData();
    Map<String, dynamic> response = moviesData;
    List<dynamic> result = response["results"];
    result.forEach((element) => movies.add(Movie.fromJson(element)));
    print(movies.length);
    return movies;
  }
}
