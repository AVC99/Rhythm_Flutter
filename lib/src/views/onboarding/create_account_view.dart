import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/core/validations/input_field_validator.dart';
import 'package:rhythm/src/views/home/home_view.dart';
import 'package:rhythm/src/widgets/dialogs/dialog_helper.dart';
import 'package:rhythm/src/widgets/dialogs/widgets/popup_dialog.dart';
import 'package:rhythm/src/widgets/image_pickers/image_picker_helper.dart';
import 'package:rhythm/src/widgets/image_pickers/widgets/circle_image_picker.dart';
import 'package:rhythm/src/widgets/inputs/input_date_field.dart';
import 'package:rhythm/src/widgets/inputs/input_text_field.dart';
import 'package:rhythm/src/widgets/buttons/large_action_button.dart';

class CreateAccountView extends StatefulWidget {
  static const String route = '/createAccount';

  const CreateAccountView({Key? key}) : super(key: key);

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  File? _selectedImage;
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
      onChanged: (value) {},
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
      onChanged: (value) {},
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
      onChanged: (value) {},
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
      onPressed: () {
        // if (_formKey.currentState!.validate()) {}
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeView.route,
          (route) => false,
        );
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
