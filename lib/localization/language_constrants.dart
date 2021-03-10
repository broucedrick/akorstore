import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/localization/app_localization.dart';

String getTranslated(String key, BuildContext context) {
  return AppLocalization.of(context).translate(key);
}