import 'package:flutter/material.dart';

import 'package:rhythm/src/widgets/texts/sliding_text.dart';

class LabeledImageHolder extends StatelessWidget {
  final double width;
  final double height;

  const LabeledImageHolder({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String imageSource =
        'https://i.scdn.co/image/ab6761610000e5ebbf108de19539a11669610d67';

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Image.network(
              imageSource,
              fit: BoxFit.cover,
            ),
          ),
          const SlidingText(child: Text('Feid'))
        ],

    );
  }
}
