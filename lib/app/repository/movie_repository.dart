import '../models/movie_details_model.dart';
import '../models/movie_model.dart';

abstract class MovieRepository {
  Future<List<Movie>> searchMovie(String movie, int pageNumber);
  Future<List<Movie>> getTopMovies(int pageNumber);
  Future<int> getTotalPagesSearchMovies(String movie);
  Future<int> getTotalPagesTopMovie();
  Future<MovieDetailsModel> getMovie(String id);
  Future<List<Movie>> getUpcomingMovies();
}
