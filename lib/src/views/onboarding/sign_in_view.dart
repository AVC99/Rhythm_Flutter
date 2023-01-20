import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/core/validations/input_field_validator.dart';
import 'package:rhythm/src/views/onboarding/reset_password_view.dart';
import 'package:rhythm/src/views/onboarding/sign_up_view.dart';
import 'package:rhythm/src/widgets/large_action_button.dart';
import 'package:rhythm/src/widgets/vertical_rhythm_banner.dart';
import 'package:rhythm/src/widgets/input_text_field.dart';

class SignInView extends StatefulWidget {
  static const route = '/signIn';

  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isKeyboardVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                  VerticalRhythmBanner(
                    subtitle: AppLocalizations.of(context)!.signInToContinue,
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
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
      validator: (value) => FieldValidator.emailValidator(context, value),
    );
  }

  Widget _buildPasswordField() {
    return InputTextField(
      controller: _passwordController,
      width: MediaQuery.of(context).size.width / 1.25,
      icon: const Icon(Icons.password),
      hint: AppLocalizations.of(context)!.password,
      isPasswordField: true,
      textInputAction: TextInputAction.done,
      onChanged: (value) {},
      validator: (value) => FieldValidator.passwordValidator(context, value),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildEmailField(),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          _buildPasswordField(),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.25,
            child: GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, ResetPasswordView.route),
              child: Text(
                AppLocalizations.of(context)!.forgotPassword,
                style: kActionText,
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LargeActionButton(
          label: AppLocalizations.of(context)!.signIn,
          width: MediaQuery.of(context).size.width / 1.5,
          onPressed: () {
            if (_formKey.currentState!.validate()) {}
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 15),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpView.route),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.dontHaveAnAccount,
                style: kTextLine,
              ),
              const SizedBox(width: 3.0),
              Text(
                AppLocalizations.of(context)!.register,
                style: kActionText,
              ),
            ],
          ),
        )
      ],
    );
  }
}
