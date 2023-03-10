import 'package:app/constants/routes.dart';
import 'package:app/services/auth/auth_exceptions.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/utilities/dialogs/error_dialog.dart';
import 'package:app/utilities/form_validation/input_validation.dart';
import 'package:flutter/material.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool rememberMeCheckboxValue = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                hintText: 'Enter your email here.',
                labelText: 'Email',
              ),
              validator: (value) => isEmailValid(value!),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _password,
              decoration: const InputDecoration(
                hintText: 'Enter your password here.',
                labelText: 'Password',
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your password' : null,
              obscureText: true,
            ),
            CheckboxListTile(
              title: const Text('Remember me for 30 days.'),
              value: rememberMeCheckboxValue,
              shape: const CircleBorder(),
              onChanged: (value) {
                setState(
                  () {
                    rememberMeCheckboxValue = value!;
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                final rememberMe = rememberMeCheckboxValue;
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
                    final user = await AuthService().logIn(
                      email: email,
                      password: password,
                      rememberMe: rememberMe,
                    );
                    if (user != null) {
                      if (!mounted) return;
                      Navigator.of(context).pop();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        loggedInRoute,
                        (route) => false,
                      );
                    }
                  }
                } on InvalidCredentialsAuthException {
                  Navigator.of(context).pop();
                  showErrorDialog(
                      context, 'Invalid Credentials. Please Try Again.');
                } on EmailNotVerifiedAuthException {
                  Navigator.of(context).pop();
                  showErrorDialog(context,
                      'Your email is not verified. Please verify it before logging in.');
                } on GenericAuthException {
                  Navigator.of(context).pop();
                  showErrorDialog(context, 'Something went wrong!');
                }
              },
              child: const Text('Log In'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  signUpRoute,
                  (route) => false,
                );
              },
              child: const Text('Don\'t have an account? Sign up here!'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  resetPasswordRoute,
                );
              },
              child: const Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }
}
