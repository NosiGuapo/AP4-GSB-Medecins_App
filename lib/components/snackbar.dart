import 'package:flutter/material.dart';
import 'package:ap4_gsbmedecins_appli/constants.dart';


SnackBar buildSnackBar(bool isSuccess, String message) {
  Color bgColour;
  if (isSuccess) {
    bgColour = successSnackbar;
  } else {
    bgColour = failSnackbar;
  }
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(
          fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w400),
    ),
    duration: const Duration(seconds: 3),
    backgroundColor: bgColour,
    width: 350.0,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

