import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/src/core/resources/images.dart';
import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/core/validations/input_field_validator.dart';
import 'package:rhythm/src/widgets/vertical_rhythm_banner.dart';
import 'package:rhythm/src/widgets/svg_image.dart';
import 'package:rhythm/src/widgets/input_text_field.dart';
import 'package:rhythm/src/widgets/large_action_button.dart';

class ResetPasswordView extends StatefulWidget {
  static const String route = '/resetPassword';

  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isKeyboardVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: _isKeyboardVisible
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.25,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const VerticalRhythmBanner(
                    subtitle: '',
                  ),
                  _buildForm(context),
                  _buildFooter(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return InputTextField(
      controller: _emailController,
      width: MediaQuery.of(context).size.width / 1.25,
      hint: AppLocalizations.of(context)!.email,
      icon: const Icon(Icons.email_rounded),
      isPasswordField: false,
      onChanged: (value) {},
      validator: (value) => FieldValidator.emailValidator(context, value),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgImage(
            svg: kForgotPasswordIllustration,
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 5,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.forgotPassword,
                    style: kSectionTitle,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 60),
                Text(
                  AppLocalizations.of(context)!.forgotPasswordInstructions,
                  style: kTextLine,
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          _buildEmailField(),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LargeActionButton(
          label: AppLocalizations.of(context)!.resetPassword,
          width: MediaQuery.of(context).size.width / 1.5,
          onPressed: () {
            if (_formKey.currentState!.validate()) {}
          },
        ),
      ],
    );
  }
}
