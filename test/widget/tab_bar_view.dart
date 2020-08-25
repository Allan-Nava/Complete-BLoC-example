import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authentication_bloc.dart';
import 'package:flutter_app/blocs/login_bloc.dart';
import 'package:flutter_app/routes/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'mock_material.dart';

class MockAuthenticationBloc extends MockBloc<AuthenticationState> implements AuthenticationBloc {}
class MockCredentialsBloc extends MockBloc<CredentialsState> implements CredentialsBloc {}

void main() {

  final MockAuthenticationBloc authBloc = MockAuthenticationBloc();
  final MockCredentialsBloc credentialsBloc = MockCredentialsBloc();

  testWidgets("Testing the authentication bloc", (tester) async {

    whenListen<AuthenticationState>(authBloc, Stream.fromIterable(const [
      AuthenticationLoading(),
      AuthenticationSuccess(),
    ]));

    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc..add(const LoggedIn()),
        child: MockMaterialApp(
          child: const HomePage(),
        ),
      )
    );

    expect(find.byType(IconButton), findsOneWidget);
  });

}