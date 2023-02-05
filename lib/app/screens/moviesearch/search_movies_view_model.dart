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
  String errorMessage = '';
  bool onPagination = false;

  SearchMoviesViewModel({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  setOnPagination(bool onPagination) {
    this.onPagination = onPagination;
    notifyListeners();
  }

  Future<void> fetchMoviesData(String movie) async {
    errorMessage = '';
    try {
      if (page <= totalPages) {
        print('To na pagina $page e o total é $totalPages');
        isLoadingMovies = true;
        List<Movie> movies = await _movieRepository.searchMovie(movie, page);
        totalPages = await _movieRepository.getTotalPagesSearchMovies(movie);
        if (movies.isNotEmpty) {
          for (Movie item in movies) {
            String date = Formatters.dateFormater(item.releaseDate);
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

  void checkSearch(String itemSearch) async {
    errorMessage = '';
    if (itemSearch.length > 3) {
      clearSearch();
      await fetchMoviesData(itemSearch);
    }
    if (itemSearch.isEmpty) {
      clearSearch();
    }
  }

  void deletePosterMovies() {
    posterMovies.clear();
    isLoadingMovies = false;
    notifyListeners();
  }

  clearSearch() {
    page = 1;
    totalPages = 1;
    onPagination = false;
    deletePosterMovies();
    notifyListeners();
  }
}
