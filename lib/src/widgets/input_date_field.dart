import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:rhythm/src/core/resources/colors.dart';
import 'package:rhythm/src/core/theme/theme_cubit.dart';

class InputDateField extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final String hint;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  const InputDateField({
    Key? key,
    required this.controller,
    required this.width,
    required this.hint,
    this.textInputAction = TextInputAction.done,
    this.validator,
  }) : super(key: key);

  @override
  State<InputDateField> createState() => _InputDateFieldState();
}

class _InputDateFieldState extends State<InputDateField> {
  DateTime? pickedDate;
  bool isPasswordVisible = false;

  Color _getThemeColor(String mode) {
    return mode == ThemeMode.light.name ? kLightBlack : kTransparentGrey;
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
                  controller: widget.controller,
                  keyboardType: TextInputType.datetime,
                  readOnly: true,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.calendar_month),
                    iconColor: _getThemeColor(state.themeMode.name),
                    hintText: widget.hint,
                    border: InputBorder.none,
                  ),
                  textInputAction: widget.textInputAction,
                  onTap: () => _showDatePicker(context),
                  validator: widget.validator,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    const int years = 100;

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: years * 365)),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        String locale = Localizations.localeOf(context).languageCode;
        widget.controller.text = DateFormat.yMMMMd(locale).format(pickedDate);
      });
    }
  }
}
