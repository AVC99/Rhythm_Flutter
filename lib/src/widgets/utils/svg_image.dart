import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  final String svg;
  final double width;
  final double height;
  final Color? color;

  const SvgImage({
    Key? key,
    required this.svg,
    required this.width,
    required this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svg,
      width: width,
      height: height,
      color: color,
    );
  }
}
