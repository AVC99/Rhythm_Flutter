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
        'https://i.pinimg.com/564x/8e/44/7c/8e447c70c2f1019d981e7871434d7a5f.jpg';

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
        const SlidingText(child: Text('Eladio Camión'))
      ],
    );
  }
}
