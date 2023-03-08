import 'package:app/services/auth/auth_exceptions.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

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
                final email = _email.text;
                final password = _password.text;
                try {
                  final user = await AuthService().logIn(
                    email: email,
                    password: password,
                  );
                } on InvalidCredentialsAuthException {
                  // TODO: IMPLEMENT
                } on EmailNotVerifiedAuthException {
                  // TODO: IMPLEMENT
                } on GenericAuthException {
                  // TODO: IMPLEMENT
                }
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
