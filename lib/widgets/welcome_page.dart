import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authentication_bloc.dart';
import 'package:flutter_app/localization/app_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localize("title")),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context
                .bloc<AuthenticationBloc>()
                .add(LoggedOut()),
          )
        ],
      ),
      body: Center(
        child: Text(context.localize("welcome")),
      ),
    );
  }
}