import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/core/utils/dates.dart';
import 'package:rhythm/src/core/validations/input_field_validator.dart';
import 'package:rhythm/src/models/rhythm_user.dart';
import 'package:rhythm/src/controllers/authentication/authentication_controller.dart';
import 'package:rhythm/src/controllers/firestore/firestore_state.dart';
import 'package:rhythm/src/controllers/firestore/users_controller.dart';
import 'package:rhythm/src/controllers/storage/storage_controller.dart';
import 'package:rhythm/src/controllers/storage/storage_state.dart';
import 'package:rhythm/src/views/home/home_view.dart';
import 'package:rhythm/src/widgets/dialogs/dialog_helper.dart';
import 'package:rhythm/src/widgets/dialogs/widgets/loading_spinner.dart';
import 'package:rhythm/src/widgets/dialogs/widgets/popup_dialog.dart';
import 'package:rhythm/src/widgets/image_pickers/image_picker_helper.dart';
import 'package:rhythm/src/widgets/image_pickers/widgets/circle_image_picker.dart';
import 'package:rhythm/src/widgets/inputs/input_date_field.dart';
import 'package:rhythm/src/widgets/inputs/input_text_field.dart';
import 'package:rhythm/src/widgets/buttons/large_action_button.dart';

class CreateAccountView extends StatefulHookConsumerWidget {
  static const String route = '/createAccount';

  final String email;
  final String password;

  const CreateAccountView({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  ConsumerState<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends ConsumerState<CreateAccountView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  File? _selectedImage;
  RhythmUser? _createdUser;
  bool _isKeyboardVisible = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _dateOfBirthController.dispose();
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

        if (nextState.runtimeType is FirestoreQueryLoadingState ||
            nextState.runtimeType is StorageLoadingState) {
          loadingDialog.displayDialog(context);
        } else if (previousState.runtimeType is FirestoreQueryLoadingState ||
            previousState.runtimeType is StorageLoadingState) {
          loadingDialog.dismissDialog(context);
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
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildImagePicker(context),
                    _buildForm(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return CircleImagePicker(
      image: _selectedImage,
      radius: MediaQuery.of(context).size.width / 4,
      onTap: () async {
        _selectedImage = await ImagePickerHelper.pickImage(() {
          final DialogHelper errorDialog = DialogHelper(
            child: PopupDialog(
              title: AppLocalizations.of(context)!.onPickImageError,
              description:
                  AppLocalizations.of(context)!.onPickImageErrorDescription,
              onAccept: () => Navigator.of(context).pop(),
            ),
            canBeDismissed: true,
          );

          errorDialog.displayDialog(context);
        });

        setState(() {
          _selectedImage;
        });
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 16,
      ),
      child: Text(
        AppLocalizations.of(context)!.profile,
        style: kSectionTitle,
      ),
    );
  }

  Widget _buildFirstNameField(BuildContext context) {
    return InputTextField(
      controller: _firstNameController,
      width: MediaQuery.of(context).size.width / 1.25,
      icon: const Icon(Icons.account_circle),
      hint: AppLocalizations.of(context)!.firstName,
      isPasswordField: false,
      textInputAction: TextInputAction.next,
      onChanged: (value) => _firstNameController.text = value!,
      validator: (value) => FieldValidator.regularValidator(context, value),
    );
  }

  Widget _buildLastNameField(BuildContext context) {
    return InputTextField(
      controller: _lastNameController,
      width: MediaQuery.of(context).size.width / 1.25,
      icon: const Icon(Icons.account_circle),
      hint: AppLocalizations.of(context)!.lastName,
      isPasswordField: false,
      textInputAction: TextInputAction.next,
      onChanged: (value) => _lastNameController.text = value!,
      validator: (value) => FieldValidator.regularValidator(context, value),
    );
  }

  Widget _buildUsernameField(BuildContext context) {
    return InputTextField(
      controller: _usernameController,
      width: MediaQuery.of(context).size.width / 1.25,
      icon: const Icon(Icons.alternate_email),
      hint: AppLocalizations.of(context)!.username,
      isPasswordField: false,
      textInputAction: TextInputAction.next,
      onChanged: (value) => _usernameController.text = value!,
      validator: (value) => FieldValidator.regularValidator(context, value),
    );
  }

  Widget _buildDateOfBirthField(BuildContext context) {
    return InputDateField(
      controller: _dateOfBirthController,
      width: MediaQuery.of(context).size.width / 1.25,
      hint: AppLocalizations.of(context)!.dateOfBirth,
      textInputAction: TextInputAction.done,
      validator: (value) => FieldValidator.userAgeValidator(
        context,
        value,
        Localizations.localeOf(context).languageCode,
      ),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return LargeActionButton(
      label: AppLocalizations.of(context)!.createAccount,
      width: MediaQuery.of(context).size.width / 1.5,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          final bool existsUsername = await ref
              .read(usersControllerProvider.notifier)
              .existsUsername(_usernameController.text);

          if (existsUsername) {
            if (!mounted) return;

            final usernameAlreadyInUseDialog = DialogHelper(
              child: PopupDialog(
                title: AppLocalizations.of(context)!.createAccountFailed,
                description:
                    AppLocalizations.of(context)!.usernameAlreadyInUseError,
                onAccept: () {
                  Navigator.of(context).pop();
                },
              ),
              canBeDismissed: true,
            );

            usernameAlreadyInUseDialog.displayDialog(context);
          } else {
            if (!mounted) return;

            String? imageUrl;
            if (_selectedImage != null) {
              imageUrl = await ref
                  .read(storageControllerProvider.notifier)
                  .uploadProfileAvatar(
                    _selectedImage!,
                    _usernameController.text,
                  );
            }

            if (!mounted) return;

            _createdUser = RhythmUser(
              email: widget.email,
              password: widget.password,
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              username: _usernameController.text,
              dateOfBirth: Dates.fromDatetime(
                _dateOfBirthController.text,
                Localizations.localeOf(context).languageCode,
              ),
              imageUrl: imageUrl ?? '',
              creationDate: DateTime.now(),
            );

            ref.read(authenticationControllerProvider.notifier).createUser(
                  _createdUser!,
                );

            if (!mounted) return;

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeView(
                  user: _createdUser,
                ),
              ),
              (route) => false,
            );
          }
        }
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildTitle(context),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          _buildFirstNameField(context),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          _buildLastNameField(context),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          _buildUsernameField(context),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          _buildDateOfBirthField(context),
          SizedBox(height: MediaQuery.of(context).size.height / 25),
          _buildCreateAccountButton(context),
        ],
      ),
    );
  }
}
