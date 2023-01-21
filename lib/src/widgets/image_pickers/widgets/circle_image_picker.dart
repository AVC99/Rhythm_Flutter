import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rhythm/src/core/theme/theme_cubit.dart';
import 'package:rhythm/src/core/resources/colors.dart';

class CircleImagePicker extends StatefulWidget {
  final File? image;
  final double radius;
  final Function()? onTap;

  const CircleImagePicker({
    Key? key,
    this.image,
    required this.radius,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CircleImagePicker> createState() => _CircleImagePickerState();
}

class _CircleImagePickerState extends State<CircleImagePicker> {
  Color _getThemeColor(String mode) {
    return mode == ThemeMode.light.name ? kGrey : kBrokenWhite;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: widget.onTap,
          child: Stack(
            children: [
              Container(
                width: widget.radius,
                height: widget.radius,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2.0,
                    color: _getThemeColor(state.themeMode.name),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: widget.image != null
                    ? Image.file(
                        widget.image!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Icon(
                          Icons.image,
                          color: _getThemeColor(state.themeMode.name),
                        ),
                      ),
              ),
              const Positioned(
                right: 0.0,
                bottom: 0.0,
                child: CircleAvatar(
                  backgroundColor: kSkyBlue,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
