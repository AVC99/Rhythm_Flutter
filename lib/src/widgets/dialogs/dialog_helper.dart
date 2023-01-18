import 'package:flutter/material.dart';

class DialogHelper {
  final Widget child;
  final bool canBeDismissed;

  const DialogHelper({
    required this.child,
    required this.canBeDismissed,
  });

  void displayDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: canBeDismissed,
      builder: (BuildContext context) {
        return child;
      },
    );
  }

  void dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
