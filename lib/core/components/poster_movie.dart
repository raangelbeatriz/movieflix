import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PosterMovie extends StatelessWidget {
  const PosterMovie({
    required this.id,
    required this.poster,
  });

  final id;
  final String? poster;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.5,
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
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
