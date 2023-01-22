import 'package:flutter/material.dart';
import 'package:movieflix/constants.dart';
import 'package:movieflix/screens/Movie%20Details/movie_details.dart';
import 'package:movieflix/screens/Home%20Page/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/Routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageViewModel homePageViewModel;
  PageController pageController = PageController();

  @override
  void initState() {
    Provider.of<HomePageViewModel>(context, listen: false).fetchPopularMovies();
    Provider.of<HomePageViewModel>(context, listen: false)
        .fetchUpcomingMovies();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    homePageViewModel = context.read<HomePageViewModel>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    homePageViewModel.deletePosterMovies();
    homePageViewModel.deleteTrendingMovies();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kbackgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.searchMovies);
            },
            icon: const Icon(Icons.search),
          )
        ],
        title: const Text(kTitleApp),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Upcoming",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Center(
                  child: SizedBox(
                    height: size.height * 0.35, //0.35
                    width: size.width,
                    child: Consumer<HomePageViewModel>(
                      builder: (context, value, child) {
                        if (value.isLoadingMovies) {
                          return const CircularProgressIndicator();
                        } else if (value.posterMovies.isNotEmpty) {
                          return PageView.builder(
                            controller: pageController,
                            itemCount: value.posterTrendingMovies.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return MovieDetailsPage(
                                            id: value
                                                .posterTrendingMovies[index]
                                                .id!,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: value.posterTrendingMovies[index]);
                            },
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ),
                Center(
                  child: Consumer<HomePageViewModel>(
                      builder: (context, value, child) {
                    return SmoothPageIndicator(
                      controller: pageController,
                      count: value.posterTrendingMovies.length,
                      effect: const SlideEffect(
                        activeDotColor: ksecondColor,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Text(
                  "Popular Movies",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.38, //300
                  width: size.width,
                  child: Consumer<HomePageViewModel>(
                    builder: (context, value, child) {
                      if (value.isLoadingMovies) {
                        return const CircularProgressIndicator();
                      } else if (value.posterMovies.isNotEmpty) {
                        return NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification.metrics.maxScrollExtent ==
                                notification.metrics.pixels) {
                              if (value.isLoadingMovies == false &&
                                  value.page < value.totalPages) {
                                value.fetchPopularMovies();
                              }
                            } else {}
                            return true;
                          },
                          child: ListView.builder(
                            itemCount: value.posterMovies.length,
                            scrollDirection: Axis.horizontal,
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
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
