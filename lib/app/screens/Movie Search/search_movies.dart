import 'package:flutter/material.dart';
import 'package:movieflix/app/core/debounce/debounce.dart';
import 'package:movieflix/app/core/ui/helpers/messages.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'search_movies_view_model.dart';

class SearchMoviesPage extends StatefulWidget {
  const SearchMoviesPage({Key? key}) : super(key: key);

  @override
  State<SearchMoviesPage> createState() => _SearchMoviesPageState();
}

class _SearchMoviesPageState extends State<SearchMoviesPage> with Messages {
  late SearchMoviesViewModel searchMoviesViewModel;
  final _debounce = Debouncer(milliseconds: 600);
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      searchMoviesViewModel =
          Provider.of<SearchMoviesViewModel>(context, listen: false);
      searchMoviesViewModel.addListener(() {
        if (searchMoviesViewModel.errorMessage.isNotEmpty) {
          showError(searchMoviesViewModel.errorMessage);
        }
      });
    });
  }

  @override
  void dispose() {
    searchMoviesViewModel.deletePosterMovies();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? itemSearch;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kbackgroundColor,
        title: const Text(kTitleApp),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Search',
                            ),
                            onChanged: (value) async {
                              itemSearch = value;
                              _debounce.run(() async {
                                searchMoviesViewModel.checkSearch(itemSearch);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.8,
                width: size.width,
                child: Consumer<SearchMoviesViewModel>(
                  builder: (context, value, child) {
                    if (value.isLoadingMovies && value.searching) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (value.searching == false) {
                      return const SizedBox.shrink();
                    } else if (value.posterMovies.isNotEmpty) {
                      return NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification.metrics.maxScrollExtent ==
                              notification.metrics.pixels) {
                            if (searchMoviesViewModel.isLoadingMovies ==
                                    false &&
                                searchMoviesViewModel.page <=
                                    searchMoviesViewModel.totalPages) {
                              searchMoviesViewModel
                                  .fetchMoviesData(itemSearch ?? "");
                            }
                          }
                          return true;
                        },
                        child: ListView.builder(
                          itemCount: value.posterMovies.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return value.posterMovies[index];
                          },
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
