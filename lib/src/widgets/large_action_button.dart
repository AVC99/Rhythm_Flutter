import 'package:flutter/material.dart';

import 'package:rhythm/src/core/resources/typography.dart';

class LargeActionButton extends StatelessWidget {
  final String label;
  final double width;
  final Function() onPressed;

  const LargeActionButton({
    Key? key,
    required this.label,
    required this.width,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        width: width,
        height: 48.0,
        child: Center(
          child: Text(
            label,
            style: kLabelButton,
          ),
        ),
      ),
    );
  }
}
