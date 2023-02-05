import 'package:flutter/cupertino.dart';

import '../../core/formatters/formatters.dart';
import '../../core/components/poster_search.dart';
import '../../models/movie_model.dart';
import '../../repository/movie_repository.dart';

class SearchMoviesViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;

  List<PosterSearch> posterMovies = [];

  bool isLoadingMovies = false;
  int page = 1;
  int totalPages = 1;
  String oldMovie = "";
  int moviesLenght = 0;
  String errorMessage = '';

  SearchMoviesViewModel({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  Future<void> fetchMoviesData(String movie) async {
    errorMessage = '';
    checkSearchState(movie, oldMovie);
    movie = setMovieString(movie);
    try {
      if (page <= totalPages) {
        print('To na pagina $page e o total é $totalPages');
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
                  id: item.id!,
                  poster: item.backdropPath,
                  releaseDate: date,
                  title: item.title,
                )
              },
            );
          }
        }
        isLoadingMovies = false;
        page++;
      }
    } catch (e) {
      isLoadingMovies = false;
      errorMessage = 'Error while searching for movies';
    }
    notifyListeners();
  }

  void checkSearch(String? itemSearch) async {
    if (itemSearch != null && itemSearch.length > 3) {
      await fetchMoviesData(itemSearch);
    } else {
      deletePosterMovies();
    }
  }

  void deletePosterMovies() {
    posterMovies.clear();
    isLoadingMovies = false;
    oldMovie = "";
    notifyListeners();
  }

  String setMovieString(String movie) {
    if (movie != "") {
      oldMovie = movie;
    }
    if (movie == "" && oldMovie != "") {
      movie = oldMovie;
    }
    return movie;
  }

  void checkSearchState(String movie, String oldMovie) {
    if (movie != "" && movie != oldMovie) {
      totalPages = 1;
      page = 1;
      moviesLenght = 0;
      deletePosterMovies();
      notifyListeners();
    }
  }
}
