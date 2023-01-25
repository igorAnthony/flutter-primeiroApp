import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_primeiro_app/constants/routes.dart';

import '../firebase_options.dart';
import 'dart:developer' as devtools show log;

import '../utilities/show_error_dialog.dart';

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
        future: 
          Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
        builder:(context, snapshot) {
          switch(snapshot.connectionState){ 
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Enter your email here",
                    ),
                  ),
                  TextField(
                    controller: _password,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Enter your password here",
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try{
                        final userCredential = 
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email, 
                            password: password,
                          );
                        devtools.log(userCredential.toString());
                        Navigator.of(context).
                          pushNamedAndRemoveUntil(
                            notesRoute, 
                            (Route<dynamic> route) => false
                          );
                      } on FirebaseAuthException catch (e){
                        if(e.code == 'user-not-found'){
                          await showErrorDialog(context, "User not found");
                        }
                        else if(e.code == 'wrong-password'){
                          await showErrorDialog(context, "Wrong password");
                        }
                        else if(e.code=="invalid-email"){
                          await showErrorDialog(context, "Invalid email");
                        }else{
                          await showErrorDialog(context, "ERROR: ${e.code}");
                        }
                      } catch (e){
                        await showErrorDialog(context, "ERROR: ${e.toString()}");
                      }
                    }, 
                    child: const Text("Login"), 
                  ),
                  TextButton(onPressed:() {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute, 
                      (Route<dynamic> route) => false
                    );
                  },
                  child: const Text("Not registered yet? Register here"))
                ]
              );  
            default:
              return const Text("Loading...");
          }
          
        },
        
      ) 
    );
  }
}


