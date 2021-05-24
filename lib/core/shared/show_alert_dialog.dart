import 'package:flutter/material.dart';

Future<void> showAlertDialog({
  @required BuildContext context,
  @required String title,
  @required String content,
  @required String defaultActionText,
}) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(child: Text(content)),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(defaultActionText),
        ),
      ],
    ),
  );
}
