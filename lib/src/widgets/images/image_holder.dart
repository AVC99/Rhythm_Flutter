import 'package:flutter/material.dart';

class ImageHolder extends StatelessWidget {
  final double width;
  final double height;

  const ImageHolder({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String imageSource =
        'https://i.pinimg.com/564x/8e/44/7c/8e447c70c2f1019d981e7871434d7a5f.jpg';

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
      ),
      child: Image.network(
        imageSource,
        fit: BoxFit.cover,
      ),
    );
  }
}
