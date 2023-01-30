import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/core/validations/input_field_validator.dart';
import 'package:rhythm/src/controllers/firestore/users_controller.dart';
import 'package:rhythm/src/controllers/firestore/firestore_state.dart';
import 'package:rhythm/src/views/onboarding/create_account_view.dart';
import 'package:rhythm/src/widgets/buttons/large_action_button.dart';
import 'package:rhythm/src/widgets/banners/vertical_rhythm_banner.dart';
import 'package:rhythm/src/widgets/dialogs/dialog_helper.dart';
import 'package:rhythm/src/widgets/dialogs/widgets/loading_spinner.dart';
import 'package:rhythm/src/widgets/dialogs/widgets/popup_dialog.dart';
import 'package:rhythm/src/widgets/inputs/input_text_field.dart';

class SignUpView extends StatefulHookConsumerWidget {
  static const String route = '/signUp';

  const SignUpView({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  bool _isKeyboardVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    ref.listen<FirestoreQueryState>(
      usersControllerProvider,
      (previousState, nextState) {
        const DialogHelper loadingDialog = DialogHelper(
          child: LoadingSpinner(),
          canBeDismissed: false,
        );

        switch (nextState.runtimeType) {
          case FirestoreQueryLoadingState:
            loadingDialog.displayDialog(context);
            break;

          case FirestoreQuerySuccessState:
          case FirestoreQueryErrorState:
            loadingDialog.dismissDialog(context);
            break;
        }
      },
    );

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: _isKeyboardVisible
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.25,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    VerticalRhythmBanner(
                      subtitle: AppLocalizations.of(context)!.createNewAccount,
                    ),
                    _buildForm(context),
                    _buildFooter(context),
                  ],
                ),
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
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => setState(() => _emailController.text = value!),
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
      onChanged: (value) => setState(() => _passwordController.text = value!),
      validator: (value) => FieldValidator.passwordValidator(context, value),
    );
  }

  Widget _buildRepeatPasswordField() {
    return InputTextField(
      controller: _repeatPasswordController,
      width: MediaQuery.of(context).size.width / 1.25,
      icon: const Icon(Icons.password),
      hint: AppLocalizations.of(context)!.repeatPassword,
      isPasswordField: true,
      textInputAction: TextInputAction.done,
      onChanged: (value) =>
          setState(() => _repeatPasswordController.text = value!),
      validator: (value) => FieldValidator.repeatPasswordValidator(
        context,
        value!,
        _passwordController.text,
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildEmailField(),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          _buildPasswordField(),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          _buildRepeatPasswordField(),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LargeActionButton(
          label: AppLocalizations.of(context)!.signUp,
          width: MediaQuery.of(context).size.width / 1.5,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final bool existsEmail = await ref
                  .read(usersControllerProvider.notifier)
                  .existsEmail(_emailController.text);

              if (existsEmail) {
                if (!mounted) return;

                final emailAlreadyInUseDialog = DialogHelper(
                  child: PopupDialog(
                    title: AppLocalizations.of(context)!.createAccountFailed,
                    description:
                        AppLocalizations.of(context)!.emailAlreadyInUseError,
                    onAccept: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  canBeDismissed: true,
                );

                emailAlreadyInUseDialog.displayDialog(context);
              } else {
                if (!mounted) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateAccountView(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ),
                  ),
                );
              }
            }
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 15),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.haveAnAccount,
                style: kTextLine,
              ),
              const SizedBox(width: 3.0),
              Text(
                AppLocalizations.of(context)!.signIn,
                style: kActionText,
              ),
            ],
          ),
        )
      ],
    );
  }
}
