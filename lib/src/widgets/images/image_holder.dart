import 'package:flutter/material.dart';

class ImageHolder extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;

  const ImageHolder({
    Key? key,
    required this.width,
    required this.height,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
      ),
      child: Image.network(
       imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
