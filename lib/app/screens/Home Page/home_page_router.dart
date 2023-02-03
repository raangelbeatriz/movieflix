import 'package:flutter/material.dart';
import 'package:movieflix/app/screens/Home%20Page/home_page.dart';
import 'package:provider/provider.dart';

import 'home_view_model.dart';

class HomePageRouter {
  HomePageRouter._();

  static Widget get page => MultiProvider(
        providers: [
          ChangeNotifierProvider<HomePageViewModel>(
            create: (context) =>
                HomePageViewModel(movieRepository: context.read()),
          ),
        ],
        child: const HomePage(),
      );
}
