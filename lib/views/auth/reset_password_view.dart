import 'package:app/services/auth/auth_exceptions.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/utilities/dialogs/error_dialog.dart';
import 'package:app/utilities/dialogs/success_dialog.dart';
import 'package:app/utilities/form_validation/input_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
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
            ElevatedButton(
              onPressed: () async {
                final email = _email.text;
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
                    await AuthService().getUserByEmail(email);
                    await AuthService().sendPasswordResetLink(email);
                    if (!mounted) return;
                    Navigator.of(context).pop();
                    showSuccessDialog(context,
                        'A password reset link has been emailed to you successfully.');
                  }
                } on GenericAuthException {
                  Navigator.of(context).pop();
                  showErrorDialog(context, 'Something went wrong!');
                } on UserNotFoundAuthException {
                  Navigator.of(context).pop();
                  showErrorDialog(context, 'User not found.');
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
