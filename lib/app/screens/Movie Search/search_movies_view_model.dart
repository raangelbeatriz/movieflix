import 'package:flutter/cupertino.dart';

import '../../core/Formatters/formatters.dart';
import '../../core/components/poster_search.dart';
import '../../models/movie_model.dart';
import '../../repository/movie_repository.dart';

class SearchMoviesViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;

  List<PosterSearch> posterMovies = [];

  bool isLoadingMovies = false;
  bool searching = false;
  int page = 1;
  int totalPages = 0;
  String oldMovie = "";
  bool lastPage = false;
  int moviesLenght = 0;
  bool restart = false;
  bool specialLoading = false;

  SearchMoviesViewModel({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  Future<void> fetchMoviesData(String movie) async {
    checkSearchState(movie, oldMovie);
    movie = setMovieString(movie);
    try {
      if (lastPage == false) {
        isLoadingMovies = true;
        List<Movie> movies = await _movieRepository.searchMovie(movie, page);
        totalPages = await _movieRepository.getTotalPagesSearchMovies(movie);
        if (movies.isNotEmpty) {
          for (Movie item in movies) {
            String date = Formatters.dateFormater(item.releaseDate);
            moviesLenght++;
            print(item.title);
            posterMovies.addAll(
              {
                PosterSearch(
                  id: item.id,
                  poster: item.backdropPath,
                  releaseDate: date,
                  title: item.title,
                )
              },
            );
          }
        }
        specialLoading = false;
        isLoadingMovies = false;
        int totalPagesPlus = totalPages + 1;
        if (page == totalPagesPlus) {
          lastPage = true;
        }
        print(
            "chamadas Movies Length =  $moviesLenght, page = $page e total page = $totalPages");
        if (movies != "") {
          page++;
        }
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void deletePosterMovies() {
    posterMovies.clear();
    isLoadingMovies = false;
    searching = false;
    oldMovie = "";
  }

  String setMovieString(String movie) {
    if (movie != "") {
      oldMovie = movie;
      searching = true;
    }
    if (movie == "" && oldMovie != "") {
      movie = oldMovie;
    }
    return movie;
  }

  void checkSearchState(String movie, String oldMovie) {
    if (movie == "" && oldMovie == "") {
      deletePosterMovies();
    }
    if (movie != "" && movie != oldMovie) {
      lastPage = false;
      totalPages = 0;
      page = 1;
      restart = false;
      moviesLenght = 0;
      deletePosterMovies();
      notifyListeners();
    }
  }
}
