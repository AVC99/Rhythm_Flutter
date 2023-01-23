import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rhythm/src/core/resources/colors.dart';
import 'package:rhythm/src/core/theme/theme_cubit.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final Icon? icon;
  final String hint;
  final bool isPasswordField;
  final TextInputAction textInputAction;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const InputTextField({
    Key? key,
    required this.controller,
    required this.width,
    this.icon,
    required this.hint,
    required this.isPasswordField,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool isPasswordVisible = false;

  Color _getThemeColor(String mode) {
    return mode == ThemeMode.light.name ? kGrey : kBrokenWhite;
  }

  Widget? _handlePasswordVisibility(Color color) {
    if (widget.isPasswordField) {
      return GestureDetector(
        onTap: () => setState(() {
          isPasswordVisible = !isPasswordVisible;
        }),
        child: Icon(
          isPasswordVisible ? Icons.visibility_off : Icons.visibility,
          color: color,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              width: widget.width,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(
                  width: 2.0,
                  color: _getThemeColor(state.themeMode.name),
                ),
              ),
            ),
            SizedBox(
              width: widget.width,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 8.0,
                  bottom: 0.0,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    icon: widget.icon,
                    iconColor: _getThemeColor(state.themeMode.name),
                    hintText: widget.hint,
                    border: InputBorder.none,
                    suffixIcon: _handlePasswordVisibility(
                      _getThemeColor(state.themeMode.name),
                    ),
                  ),
                  obscureText:
                      widget.isPasswordField ? !isPasswordVisible : false,
                  textInputAction: widget.textInputAction,
                  onChanged: widget.onChanged,
                  validator: widget.validator,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
