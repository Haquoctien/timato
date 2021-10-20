import 'package:flutter/material.dart';
import 'package:timato/constants/app_theme.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.bg,
      title: const Text(
        "Delete this todo?",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text(
            "Confirm",
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(
            "Cancel",
          ),
        )
      ],
    );
  }
}
