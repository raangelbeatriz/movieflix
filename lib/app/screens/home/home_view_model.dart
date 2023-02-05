import 'package:flutter/cupertino.dart';

import '../../core/ui/components/poster_movie.dart';
import '../../core/ui/components/poster_trending_movie.dart';
import '../../models/movie_model.dart';
import '../../repository/movie_repository.dart';

class HomePageViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;
  List<PosterMovie> posterMovies = [];
  List<PosterTrendingMovie> posterTrendingMovies = [];
  bool isLoadingTrendingMovies = true;
  bool isLoadingMovies = true;
  int page = 0;
  int totalPages = 0;
  String errorMessage = '';

  HomePageViewModel({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  Future<void> fetchPopularMovies() async {
    try {
      errorMessage = '';
      isLoadingMovies = true;
      page++;
      List<Movie> movies = await _movieRepository.getTopMovies(page);
      totalPages = await _movieRepository.getTotalPagesTopMovie();
      if (movies.isNotEmpty) {
        for (Movie item in movies) {
          posterMovies
              .addAll({PosterMovie(id: item.id!, poster: item.posterPath)});
        }
      }
      isLoadingMovies = false;
    } catch (e) {
      errorMessage = 'Error while loading popular Movies';
      isLoadingMovies = false;
      print(e);
    }
    notifyListeners();
  }

  Future<void> fetchUpcomingMovies() async {
    try {
      errorMessage = '';
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
      isLoadingTrendingMovies = false;
      errorMessage = 'Error while loading upcoming movies';
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
