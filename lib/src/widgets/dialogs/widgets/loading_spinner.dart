import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:rhythm/src/core/resources/colors.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(8.0),
        child: const SpinKitWave(
          color: kSkyBlue,
        ),
      ),
    );
  }
}
