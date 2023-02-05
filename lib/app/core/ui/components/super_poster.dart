import 'package:flutter/material.dart';
import 'package:movieflix/app/core/ui/components/text_search_poster.dart';

import '../../../constants.dart';
import 'go_back_widget.dart';

class SuperPosterWidget extends StatelessWidget {
  const SuperPosterWidget({
    Key? key,
    required this.posterPath,
    required this.ranking,
    required this.releaseDate,
  }) : super(key: key);

  final String? posterPath;
  final double? ranking;
  final String? releaseDate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: posterPath != null
                ? DecorationImage(
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/original$posterPath'),
                    fit: BoxFit.cover)
                : null,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
                colors: [kbackgroundColor, Colors.transparent],
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 15,
          child: Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              const SizedBox(
                width: 10,
              ),
              Text('Rankings: $ranking'),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 200,
                child: TextSearchPoster(text: "Release Date: $releaseDate"),
              ),
            ],
          ),
        )
      ],
    );
  }
}
