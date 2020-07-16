import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rental/Services/firebase_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDataProvider extends ChangeNotifier {
  static AppDataProvider of(BuildContext context, {bool listen = false}) => Provider.of<AppDataProvider>(context, listen: listen);

  AppDataProvider(BuildContext context) {}

  SharedPreferences _sharedPreferences;
  SharedPreferences get sharedPreferences => _sharedPreferences;

  void changeLocalization(BuildContext context) {
    if (EasyLocalization.of(context).locale.languageCode == "ar")
      EasyLocalization.of(context).locale = EasyLocalization.of(context).supportedLocales.last;
    else
      EasyLocalization.of(context).locale = EasyLocalization.of(context).supportedLocales.first;
  }
}
