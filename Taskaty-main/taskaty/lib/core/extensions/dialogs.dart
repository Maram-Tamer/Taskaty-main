import 'package:flutter/material.dart';
import 'package:taskaty/core/utils/colors.dart';

showErrorDialog(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: AppColors.redColor,
      content: Text(message),
    ),
  );
}
