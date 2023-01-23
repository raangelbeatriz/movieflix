import 'package:flutter/material.dart';

class TextSearchPoster extends StatelessWidget {
  const TextSearchPoster({
    Key? key,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  final String? text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            child: Text(
              text ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
