import 'package:flutter/material.dart';
import 'package:movieflix/constants.dart';
import 'package:movieflix/screens/Movie%20Details/movie_details.dart';
import 'package:movieflix/screens/Movie%20Search/search_movies_viewmodel.dart';
import 'package:provider/provider.dart';

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
                              /*if (itemSearch != null && itemSearch != "") {
                                searchMoviesViewModel.fetchMoviesData(itemSearch!); 
                              }*/
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
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: ksecondColor,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MovieDetailsPage(
                                          id: value.posterMovies[index].id!,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: value.posterMovies[index]);
                          },
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
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

/* 
GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: size.width * 0.01,
                                  mainAxisSpacing: size.height * 0.01),
                          itemCount: value.posterMovies.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Container(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MovieDetailsPage(
                                          id: value.posterMovies[index].id!,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: value.posterMovies[index],
                              ),
                            );
                          },
                        ), 
                        
                        */

