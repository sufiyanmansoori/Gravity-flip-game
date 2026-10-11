import 'package:flutter/material.dart';

Future<void> showAppAlert({
  required BuildContext context,
  required String title,
  required String message,
  String actionText = 'OK',
}) async {
  await showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(actionText),
        ),
      ],
    ),
  );
}
