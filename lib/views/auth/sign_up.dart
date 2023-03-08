import 'package:app/constants/routes.dart';
import 'package:app/services/auth/auth_exceptions.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/views/logged_in_view.dart';
import 'package:flutter/material.dart';

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
            ),
            TextFormField(
              controller: _lastName,
              decoration: const InputDecoration(
                hintText: 'Enter your last name here.',
                labelText: 'Last Name',
              ),
              keyboardType: TextInputType.name,
            ),
            TextFormField(
              controller: _phoneNumber,
              decoration: const InputDecoration(
                hintText: 'Enter your phone number here.',
                labelText: 'Phone Number',
              ),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                hintText: 'Enter your email here.',
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _password,
              decoration: const InputDecoration(
                hintText: 'Enter your password here.',
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                final firstName = _firstName.text;
                final lastName = _lastName.text;
                final phoneNumber = _phoneNumber.text;
                final email = _email.text;
                final password = _password.text;
                try {
                  final user = await AuthService().createUser(
                    firstName: firstName,
                    lastName: lastName,
                    phoneNumber: phoneNumber,
                    email: email,
                    password: password,
                  );
                } on WeakPasswordAuthException {
                  // TODO: IMPLEMENT
                } on EmailAlreadyInUseAuthException {
                  // TODO: IMPLEMENT
                } on PhoneNumberAlreadyInUseAuthException {
                  // TODO: IMPLEMENT
                } on BothIdentifiersAlreadyInUseAuthException {
                  // TODO: IMPLEMENT
                } on InvalidEmailAuthException {
                  // TODO: IMPLEMENT
                } on InternalServerErrorAuthException {
                  // TODO: IMPLEMENT
                } on IntegrityErrorAuthException {
                  // TODO: IMPLEMENT
                } on GenericAuthException {
                  // TODO: IMPLEMENT
                }
              },
              child: const Text('Submit'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    logInRoute,
                    (route) => false,
                  );
                },
                child: const Text('Already registered? Log in here!')),
          ],
        ),
      ),
    );
  }
}
