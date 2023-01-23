import 'package:flutter/material.dart';

class SquaredIconButton extends StatelessWidget {
  final Icon icon;
  final double width;
  final Function() onPressed;

  const SquaredIconButton({
    Key? key,
    required this.icon,
    required this.width,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: SizedBox(
          width: width,
          height: 60.0,
          child: Center (
          child: icon,
          ),
        ),
    );
  }
}
