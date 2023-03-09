import 'package:app/constants/routes.dart';
import 'package:app/services/auth/auth_exceptions.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/utilities/dialogs/error_dialog.dart';
import 'package:app/utilities/dialogs/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:app/utilities/form_validation/input_validation.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _phoneNumber.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
                controller: _firstName,
                decoration: const InputDecoration(
                  hintText: 'Enter your first name here.',
                  labelText: 'First Name',
                ),
                keyboardType: TextInputType.name,
                validator: (value) => isFirstNameValid(value!)),
            TextFormField(
                controller: _lastName,
                decoration: const InputDecoration(
                  hintText: 'Enter your last name here.',
                  labelText: 'Last Name',
                ),
                keyboardType: TextInputType.name,
                validator: (value) => isLastNameValid(value!)),
            TextFormField(
              controller: _phoneNumber,
              decoration: const InputDecoration(
                hintText: 'Enter your phone number here.',
                labelText: 'Phone Number',
              ),
              keyboardType: TextInputType.phone,
              validator: (value) => isPhoneNumberValid(value!),
            ),
            TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  hintText: 'Enter your email here.',
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => isEmailValid(value!)),
            TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                  hintText: 'Enter your password here.',
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) => isPasswordValid(value!)),
            ElevatedButton(
              onPressed: () async {
                final firstName = _firstName.text;
                final lastName = _lastName.text;
                final phoneNumber = _phoneNumber.text;
                final email = _email.text;
                final password = _password.text;
                try {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      barrierDismissible: false,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      },
                      context: context,
                    );
                    if (await checkIfIdentifiersAreAvailable(
                          email,
                          phoneNumber,
                        ) ==
                        true) {
                      final user = await AuthService().createUser(
                        firstName: firstName,
                        lastName: lastName,
                        phoneNumber: phoneNumber,
                        email: email,
                        password: password,
                      );
                      if (user != null) {
                        if (!mounted) return;
                        Navigator.of(context).pop();
                        showSuccessDialog(context,
                            'You have successfully signed up. Please verify your email before logging in.');
                        dispose();
                      }
                    }
                  }
                } on WeakPasswordAuthException {
                  Navigator.of(context).pop();
                  showErrorDialog(context, 'Please choose a stronger password');
                } on EmptyFieldsAuthException {
                  Navigator.of(context).pop();
                  showErrorDialog(
                      context, 'Please fill in all the fields appropriately.');
                } on EmailAlreadyInUseAuthException {
                  Navigator.of(context).pop();
                  showErrorDialog(context, 'This email is already in use.');
                } on PhoneNumberAlreadyInUseAuthException {
                  Navigator.of(context).pop();
                  showErrorDialog(
                      context, 'This phone number is already in use');
                } on BothIdentifiersAlreadyInUseAuthException {
                  Navigator.of(context).pop();
                  showErrorDialog(
                      context, 'The email and phone number are already in use');
                } on InvalidEmailAuthException {
                  Navigator.of(context).pop();
                  showErrorDialog(context, 'Please enter a valid email.');
                } on InternalServerErrorAuthException {
                  Navigator.of(context).pop();
                  showErrorDialog(context, 'Something went wrong.');
                } on IntegrityErrorAuthException {
                  Navigator.of(context).pop();
                  showErrorDialog(context, 'Something went wrong.');
                } on GenericAuthException {
                  Navigator.of(context).pop();
                  showErrorDialog(context, 'Something went wrong.');
                }
              },
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  logInRoute,
                  (route) => false,
                );
              },
              child: const Text('Already registered? Log in here!'),
            ),
          ],
        ),
      ),
    );
  }
}
