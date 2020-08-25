import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/login_bloc.dart';
import 'package:flutter_app/widgets/separator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/localization/app_localization.dart';

class LoginForm extends StatefulWidget {
  const LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String validateEmail(String input) {
    if ((input.length > 10) && (input.contains("@"))) {
      return null;
    } else {
      return context.localize("invalid_field");
    }
  }

  String validatePassword(String input) {
    if (input.length > 5) {
      return null;
    } else {
      return context.localize("invalid_field");
    }
  }

  void loginButtonPressed(BuildContext context) {
    context.bloc<CredentialsBloc>().add(
      LoginButtonPressed(
        username: emailController.text,
        password: passwordController.text
      )
    );
  }

  void registerButtonPressed(BuildContext context) {
    context.bloc<CredentialsBloc>().add(
      RegisterButtonPressed(
        username: emailController.text,
        password: passwordController.text
      )
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, data) {
        var baseWidth = 250.0;

        // For wider screen, such as tablets
        if (data.maxWidth <= baseWidth) {
          baseWidth = data.maxWidth / 1.4;
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(
                size: 70
              ),

              const Separator(50),

              Form(
                key: formKey,
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 20,
                  children: <Widget>[
                    SizedBox(
                      width: baseWidth - 30,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          hintText: context.localize("username"),
                        ),
                        validator: validateEmail,
                        controller: emailController,
                      ),
                    ),
                    SizedBox(
                      width: baseWidth - 30,
                      child: TextFormField(
                        obscureText: true,
                        validator: validatePassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.vpn_key),
                          hintText: context.localize("password"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Separator(25),

              // Login
              BlocConsumer<CredentialsBloc, CredentialsState>(
                listener: (context, state) {
                  if (state is CredentialsLoginFailure) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 2),
                          content: Text(context.localize("error_login")),
                        )
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CredentialsLoginLoading) {
                    return const CircularProgressIndicator();
                  }

                  return RaisedButton(
                    key: Key("loginButton"),
                    child: Text(context.localize("login")),
                    color: Colors.lightGreen,
                    textColor: Colors.white,
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        loginButtonPressed(context);
                      }
                    },
                  );
                },
              ),

              const Separator(5),

              // Register
              BlocConsumer<CredentialsBloc, CredentialsState>(
                listener: (context, state) {
                  if (state is CredentialsRegisterFailure) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 2),
                          content: Text(context.localize("register_login")),
                        )
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CredentialsRegisterLoading) {
                    return const CircularProgressIndicator();
                  }

                  return RaisedButton(
                    key: Key("registerButton"),
                    child: Text(context.localize("register")),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        registerButtonPressed(context);
                      }
                    },
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}