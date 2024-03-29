import 'package:flutter/material.dart';

import 'title_widget.dart';

class SynopsisWidget extends StatelessWidget {
  const SynopsisWidget({
    Key? key,
    required this.text,
    required this.movieTitle,
  }) : super(key: key);

  final String? text;
  final String? movieTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(text: movieTitle),
          Text(
            text ?? "",
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
