import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_primeiro_app/constants/routes.dart';
import 'package:flutter_primeiro_app/services/auth/auth_exceptions.dart';
import 'package:flutter_primeiro_app/services/auth/auth_service.dart';
import 'package:flutter_primeiro_app/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_primeiro_app/services/auth/bloc/auth_event.dart';
import 'package:flutter_primeiro_app/services/auth/bloc/auth_state.dart';
import 'package:flutter_primeiro_app/utilities/decoration/text_form_field_decoration.dart';
import 'package:flutter_primeiro_app/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: FutureBuilder(
          future: AuthService.firebase().initialize(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(children: [
                    buildTextFormFieldEmail(_email),
                    buildTextFormFieldPassword(_password),
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) async {
                        if(state is AuthStateLoggedOut){
                          if(state.exception is UserNotFoundAuthException || state.exception is WrongPasswordAuthException){
                            await showErrorDialog(context, "Wrong credentials");
                          }
                          else if(state.exception is GenericAuthException){
                            await showErrorDialog(context, "Authentication error");
                          }
                        }
                      },
                      child: TextButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          context.read<AuthBloc>().add(AuthEventLogIn(email, password)); 
                        },
                        child: const Text("Login"),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            registerRoute,
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: const Text("Not registered yet? Register here")),
                  ]),
                );
              default:
                return const Text("Loading...");
            }
          },
        ));
  }
}
