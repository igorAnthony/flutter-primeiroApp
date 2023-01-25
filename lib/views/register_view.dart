import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_primeiro_app/constants/routes.dart';
import 'package:flutter_primeiro_app/firebase_options.dart';
import 'dart:developer' as devtools show log;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  
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
        title: const Text("Register"),
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
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      hintText: "Enter your email here",
                    ),
                  ),
                  TextField(
                    controller: _password,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      hintText: "Enter your password here",
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;

                      try{
                        final userCredential = 
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email, 
                            password: password,
                          );
                        devtools.log(userCredential.toString());
                        Navigator.of(context).
                          pushNamedAndRemoveUntil(
                            loginRoute, 
                            (Route<dynamic> route) => false
                          );
                      } on FirebaseAuthException catch(e){
                        if(e.code == 'weak-password'){
                          showAlertDialog(context,"Weak password");
                        }else if(e.code=='email-already-in-use'){
                          showAlertDialog(context,"Email already in use");
                        }else if(e.code=="invalid-email"){
                          showAlertDialog(context,"Invalid email");
                        }else{
                          devtools.log(e.code);
                        }
                      }
                    }, 
                    child: const Text("Register"), 
                  ),
                  TextButton(
                    onPressed:() {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute, 
                        (Route<dynamic> route) => false
                      );
                    }, 
                    child: const Text("Already registered? Login here!")
                  )
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
Future<void> showAlertDialog(BuildContext context, String stringError) async {
  showDialog(
    context: context, 
    builder:(context) {
      return AlertDialog(
        title:const Text("Register problem"),
        content: Text(stringError),
        actions: [
          TextButton(onPressed:() {
            Navigator.of(context).pop();
          }, 
          child: const Text("Ok"))
        ],
      );
    },
  );
}