import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../routes/routes.dart';

class PosterTrendingMovie extends StatelessWidget {
  const PosterTrendingMovie({
    Key? key,
    required this.id,
    required this.poster,
  }) : super(key: key);
  final id;
  final String? poster;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.movieDetails, arguments: id);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.all(15.0),
        child: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/original/$poster',
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
