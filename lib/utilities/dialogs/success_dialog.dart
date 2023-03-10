import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showSuccessDialog(BuildContext context, String text) {
  return showCupertinoDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Success!'),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Okay'),
          )
        ],
      );
    },
  );
}
