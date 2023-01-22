import 'package:flutter/material.dart';
import 'package:movieflix/core/components/text_search_poster.dart';

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
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.18,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.18,
              child: Image(
                image:
                    NetworkImage("https://image.tmdb.org/t/p/original$poster"),
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Container(
                    child: const Icon(Icons.error),
                  );
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextSearchPoster(
                    text: title,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSearchPoster(
                    text: releaseDate ?? "",
                    textStyle:
                        const TextStyle(fontSize: 10, color: Colors.grey),
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
