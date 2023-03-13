import 'package:app/constants/routes.dart';
import 'package:app/services/auth/auth_exceptions.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/utilities/dialogs/error_dialog.dart';
import 'package:app/utilities/dialogs/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:app/utilities/forms/input_validation.dart';

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
  bool _isPasswordTextObscured = true;
  Icon _passwordSuffixIcon = const Icon(Icons.visibility_outlined);

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
        title: const Text('myFaraday'),
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
          width: 350,
          height: 550,
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              controller: _firstName,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  hintText: 'Your first name',
                                  labelText: 'First Name',
                                  icon: Icon(Icons.person_outline)),
                              keyboardType: TextInputType.name,
                              validator: (value) => isFirstNameValid(value!),
                              enableSuggestions: true,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              controller: _lastName,
                              decoration: const InputDecoration(
                                hintText: 'Your last name',
                                labelText: 'Last Name',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) => isLastNameValid(value!),
                              enableSuggestions: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: TextFormField(
                        controller: _phoneNumber,
                        decoration: const InputDecoration(
                          hintText: 'Enter your phone number here.',
                          labelText: 'Phone Number',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          icon: Icon(Icons.phone_iphone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) => isPhoneNumberValid(value!),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: TextFormField(
                        controller: _email,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email here.',
                          labelText: 'Email',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          icon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => isEmailValid(value!),
                        enableSuggestions: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: TextFormField(
                        controller: _password,
                        decoration: InputDecoration(
                          hintText: 'Enter your password here.',
                          labelText: 'Password',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          icon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: _passwordSuffixIcon,
                            onPressed: () => setState(
                              () {
                                if (_isPasswordTextObscured == true) {
                                  _isPasswordTextObscured = false;
                                  _passwordSuffixIcon =
                                      const Icon(Icons.visibility_off_outlined);
                                } else {
                                  _isPasswordTextObscured = true;
                                  _passwordSuffixIcon =
                                      const Icon(Icons.visibility_outlined);
                                }
                              },
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        obscureText: _isPasswordTextObscured,
                        validator: (value) => isPasswordValid(value!),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                          showErrorDialog(
                              context, 'Please choose a stronger password');
                        } on EmptyFieldsAuthException {
                          Navigator.of(context).pop();
                          showErrorDialog(context,
                              'Please fill in all the fields appropriately.');
                        } on EmailAlreadyInUseAuthException {
                          Navigator.of(context).pop();
                          showErrorDialog(
                              context, 'This email is already in use.');
                        } on PhoneNumberAlreadyInUseAuthException {
                          Navigator.of(context).pop();
                          showErrorDialog(
                              context, 'This phone number is already in use');
                        } on BothIdentifiersAlreadyInUseAuthException {
                          Navigator.of(context).pop();
                          showErrorDialog(context,
                              'The email and phone number are already in use');
                        } on InvalidEmailAuthException {
                          Navigator.of(context).pop();
                          showErrorDialog(
                              context, 'Please enter a valid email.');
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
            ),
          ),
        ),
      ),
    );
  }
}
