import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';

void showCustomSnackBar(String message, BuildContext context, {bool isError = true}) {
  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: isError ? ColorResources.getRed(context) : Colors.green,
    content: Text(message),
  ));
}
