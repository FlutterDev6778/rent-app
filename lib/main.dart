import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

import 'Pages/App/app.dart';

void main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
  }
  runApp(
    EasyLocalization(
      child: App(),
      path: 'lib/Assets/Langs',
      useOnlyLangCode: true,
      supportedLocales: [
        Locale('ar', 'DZ'),
        Locale('en', 'US'),
      ],
      saveLocale: true,
      startLocale: Locale('ar', 'DZ'),
      fallbackLocale: Locale('ar', 'DZ'),
    ),
  );
}
