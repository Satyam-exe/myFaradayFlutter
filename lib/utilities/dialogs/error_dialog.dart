import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showErrorDialog(BuildContext context, String text) {
  return showCupertinoDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('An error occurred'),
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
      });
}
