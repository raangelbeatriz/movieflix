import '../constants.dart';
import '../models/movie_details_model.dart';
import '../models/movie_model.dart';
import '../services/networking.dart';
import 'movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  @override
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

  @override
  Future<List<Movie>> getTopMovies(int pageNumber) async {
    List<Movie> movies = [];
    NetworkHelper networkHelper = NetworkHelper(
        '$openMovieURL/movie/popular?api_key=$apiKey&language=en-US&page=$pageNumber');

    var moviesData = await networkHelper.getData();
    Map<String, dynamic> response = moviesData;
    List<dynamic> result = response["results"];
    for (var element in result) {
      movies.add(Movie.fromJson(element));
    }
    int totalPage = response["total_pages"] ?? 0;
    return movies;
  }

  @override
  Future<int> getTotalPagesSearchMovies(String movie) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openMovieURL/search/movie?api_key=$apiKey&language=en-US&query=$movie&page=1&include_adult=false');

    var moviesData = await networkHelper.getData();
    Map<String, dynamic> response = moviesData;
    int totalPageSearch = response["total_pages"] ?? 0;
    print("Total pages = $totalPageSearch");
    return totalPageSearch;
  }

  @override
  Future<int> getTotalPagesTopMovie() async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openMovieURL/movie/popular?api_key=$apiKey&language=en-US&page=1');

    var moviesData = await networkHelper.getData();
    Map<String, dynamic> response = moviesData;
    int totalPage = response["total_pages"] ?? 0;
    return totalPage;
  }

  @override
  Future<List<Movie>> getUpcomingMovies() async {
    print("request");
    List<Movie> movies = [];
    NetworkHelper networkHelper = NetworkHelper(
        '$openMovieURL/movie/upcoming?api_key=$apiKey&language=en-US&page=1');

    var moviesData = await networkHelper.getData();
    Map<String, dynamic> response = moviesData;
    List<dynamic> result = response["results"];
    for (var element in result) {
      movies.add(Movie.fromJson(element));
    }
    print(movies.length);
    return movies;
  }

  @override
  Future<List<Movie>> searchMovie(String movie, int pageNumber) async {
    List<Movie> movies = [];
    try {
      NetworkHelper networkHelper = NetworkHelper(
          '$openMovieURL/search/movie?api_key=$apiKey&language=en-US&query=$movie&page=$pageNumber&include_adult=false');

      var moviesData = await networkHelper.getData();
      Map<String, dynamic> response = moviesData;
      List<dynamic> result = response["results"];
      for (var element in result) {
        movies.add(Movie.fromJson(element));
      }
    } catch (e) {
      Exception(e);
    }
    return movies;
  }
}
