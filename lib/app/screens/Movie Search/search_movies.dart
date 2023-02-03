import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../core/Routes/routes.dart';
import '../Movie Details/movie_details.dart';
import 'search_movies_view_model.dart';

class SearchMoviesPage extends StatefulWidget {
  const SearchMoviesPage({Key? key}) : super(key: key);

  @override
  State<SearchMoviesPage> createState() => _SearchMoviesPageState();
}

class _SearchMoviesPageState extends State<SearchMoviesPage> {
  late SearchMoviesViewModel searchMoviesViewModel;
  @override
  void initState() {
    Provider.of<SearchMoviesViewModel>(context, listen: false)
        .fetchMoviesData("");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    searchMoviesViewModel =
        Provider.of<SearchMoviesViewModel>(context, listen: false);
    super.didChangeDependencies();
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
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () async {
                            print("testando $itemSearch");
                            await searchMoviesViewModel
                                .fetchMoviesData(itemSearch ?? "");
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: ksecondColor,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: const Icon(Icons.search),
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
                      return const CircularProgressIndicator();
                    } else if (value.searching == false) {
                      return Container();
                    } else if (value.posterMovies.isNotEmpty) {
                      return NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification.metrics.maxScrollExtent ==
                              notification.metrics.pixels) {
                            if (searchMoviesViewModel.isLoadingMovies ==
                                    false &&
                                searchMoviesViewModel.lastPage == false) {
                              searchMoviesViewModel
                                  .fetchMoviesData(itemSearch ?? "");
                            } else {
                              print(
                                  "Ainda carregando; loading é igual a ${searchMoviesViewModel.isLoadingMovies}");
                              return true;
                            }
                          }
                          return true;
                        },
                        child: ListView.builder(
                          itemCount: value.posterMovies.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.movieDetails,
                                      arguments: value.posterMovies[index].id!);
                                },
                                child: value.posterMovies[index]);
                          },
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
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
