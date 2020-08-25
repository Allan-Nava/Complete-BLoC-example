import 'package:flutter/material.dart';
import 'package:flutter_app/localization/localization_delegate.dart';
import 'package:flutter_app/repository/user_repository/firebase_repository.dart';
import 'package:flutter_app/repository/user_repository/test_repository.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_app/localization/app_localization.dart';
import 'package:provider/provider.dart';

import 'blocs/authentication_bloc.dart';

void main() => runApp(
  Provider<TestUserRepository>(
    create: (_) => const TestUserRepository(
      fakeEmail: "alberto@miola.it",
      success: true,
    ),
    child: const LoginApp(),
  )
);

class LoginApp extends StatelessWidget {
  const LoginApp();

  @override
  Widget build(BuildContext context) {
    final repository = context.select((TestUserRepository r) => r);

    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(repository),
      child: MaterialApp(
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,

        localizationsDelegates: [
          const AppLocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale.fromSubtags(languageCode: "en"),
          Locale.fromSubtags(languageCode: "it"), ],

        onGenerateTitle: (context) => context.localize("title"),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

}
