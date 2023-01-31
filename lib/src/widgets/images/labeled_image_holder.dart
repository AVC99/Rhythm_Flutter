import 'package:flutter/material.dart';

import 'package:rhythm/src/widgets/texts/sliding_text.dart';

class LabeledImageHolder extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final String description;

  const LabeledImageHolder({
    Key? key,
    required this.width,
    required this.height,
    required this.url,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            height: height,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SlidingText(child: Text(description))
      ],
    );
  }
}
