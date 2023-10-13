import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../main.dart';

enum SnackBarType { error, success, warning }

void showMySnackBar(
  // BuildContext context,
  String message, {
  SnackBarType type = SnackBarType.error,
  SnackBarAction? action,
}) {
  final colorScheme =
      Theme.of(scaffoldMessengerKey.currentContext!).colorScheme;
  SnackBar snackBar;

  switch (type) {
    case SnackBarType.success:
      snackBar = _buildSnackBar(
        message: message,
        textColor: colorScheme.onPrimary,
        // greener color than primary
        backgroundColor: Colors.green,
        action: action,
      );
      break;

    case SnackBarType.warning:
      snackBar = _buildSnackBar(
        message: message,
        textColor: colorScheme.onSecondary,
        backgroundColor: colorScheme.secondary,
        action: action,
      );
      break;
    case SnackBarType.error:
      snackBar = _buildSnackBar(
        message: message,
        textColor: colorScheme.onError,
        backgroundColor: colorScheme.error,
        action: action,
      );
      break;
    default:
      throw Exception('Unknown SnackBarType: $type');
  }
  SchedulerBinding.instance.addPostFrameCallback((_) {
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);

    // pop snackbar
    // scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  });
}

SnackBar _buildSnackBar({
  required String message,
  required Color textColor,
  required Color backgroundColor,
  SnackBarAction? action,
}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(
      message,
      style: TextStyle(color: textColor),
    ),
    backgroundColor: backgroundColor,
    action: action,
  );
}
