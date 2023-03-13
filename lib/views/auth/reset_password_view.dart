import 'package:app/services/auth/auth_exceptions.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/utilities/dialogs/error_dialog.dart';
import 'package:app/utilities/dialogs/success_dialog.dart';
import 'package:app/utilities/forms/input_validation.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Colors.lightBlue[200],
      body: Center(
        child: Container(
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                side: BorderSide(color: Colors.black)),
          ),
          width: 325,
          height: 300,
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        controller: _email,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            hintText: 'Enter your email here.',
                            labelText: 'Email',
                            icon: Icon(Icons.email_outlined)),
                        validator: (value) => isEmailValid(value!),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
            ),
          ),
        ),
      ),
    );
  }
}
