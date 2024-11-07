import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:negup_test/core/constants/constants.dart';

class SnackbarService {
  static final SnackbarService _instance = SnackbarService._internal();

  SnackbarService._internal();

  factory SnackbarService() {
    return _instance;
  }

  void showSnackBar(
    String message, {
    required BuildContext context,
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? snackBarAction,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        content: Text(message,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        duration: duration,
        action: snackBarAction,
        behavior: behavior,
      ),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
