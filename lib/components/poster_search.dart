import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/components/text_search_poster.dart';

class PosterSearch extends StatelessWidget {
  const PosterSearch({
    Key? key,
    required this.poster,
    required this.title,
    required this.releaseDate,
    required this.id,
  }) : super(key: key);

  final id;
  final String? poster;
  final String? title;
  final String? releaseDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.18,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*CachedNetworkImage(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.18,
              imageUrl: "https://image.tmdb.org/t/p/original$poster",
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ), */
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.18,
              child: Image(
                image:
                    NetworkImage("https://image.tmdb.org/t/p/original$poster"),
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Container(
                    child: Icon(Icons.error),
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextSearchPoster(
                    text: title,
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSearchPoster(
                    text: releaseDate ?? "",
                    textStyle: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
