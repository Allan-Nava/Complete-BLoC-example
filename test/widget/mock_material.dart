import 'package:flutter/material.dart';
import 'package:flutter_app/localization/localization_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MockMaterialApp extends StatelessWidget {
  final Widget child;
  const MockMaterialApp({
    @required this.child
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale.fromSubtags(languageCode: "en"),
        Locale.fromSubtags(languageCode: "it"),
      ],
      home: child,
    );
  }
}