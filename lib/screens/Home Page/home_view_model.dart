import 'package:flutter/cupertino.dart';
import 'package:movieflix/components/poster_movie.dart';
import 'package:movieflix/components/poster_trending_movie.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/repository/movie_repository.dart';
import 'package:movieflix/services/request_helper.dart';

class HomePageViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;
  List<PosterMovie> posterMovies = [];
  List<PosterTrendingMovie> posterTrendingMovies = [];
  bool isLoadingTrendingMovies = false;
  bool isLoadingMovies = false;
  int page = 0;
  int totalPages = 0;

  HomePageViewModel({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  Future<void> fetchPopularMovies() async {
    try {
      isLoadingMovies = true;
      page++;
      List<Movie> movies = await RequestHelper().getTopMovies(page);
      totalPages = await _movieRepository.getTotalPagesTopMovie();
      if (movies.isNotEmpty) {
        for (Movie item in movies) {
          posterMovies
              .addAll({PosterMovie(id: item.id, poster: item.posterPath)});
        }
      }
      isLoadingMovies = false;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> fetchUpcomingMovies() async {
    try {
      isLoadingTrendingMovies = true;
      List<Movie> trendingMovies = await _movieRepository.getUpcomingMovies();
      if (trendingMovies.isNotEmpty) {
        if (trendingMovies.length < 5) {
          for (Movie item in trendingMovies) {
            posterTrendingMovies.addAll(
                {PosterTrendingMovie(id: item.id, poster: item.backdropPath)});
          }
        } else {
          int i = 0;
          while (i < 5) {
            posterTrendingMovies.add(PosterTrendingMovie(
                id: trendingMovies[i].id,
                poster: trendingMovies[i].backdropPath));
            i++;
          }
        }
      }
      isLoadingTrendingMovies = false;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void deletePosterMovies() {
    posterMovies.clear();
    isLoadingMovies = false;
  }

  void deleteTrendingMovies() {
    posterTrendingMovies.clear();
    isLoadingTrendingMovies = false;
  }
}
