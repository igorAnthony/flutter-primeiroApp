import 'package:flutter/material.dart';

Widget buildTextFormFieldEmail(TextEditingController email) => Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 8.0),
      child: TextFormField(
        controller: email,
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(6.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(6.5),
          ),
          prefixIcon: const Icon(
            Icons.person,
            color: Colors.grey,
          ),
          labelText: "Enter your email",
          labelStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
Widget buildTextFormFieldPassword(TextEditingController password) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        controller: password,
        enableSuggestions: false,
        autocorrect: false,
        obscureText: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(6.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(6.5),
          ),
          prefixIcon: const Icon(
            Icons.lock,
            color: Colors.grey,
          ),
          labelText: "Enter your password",
          labelStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );

Widget buildTextFieldNotes(TextEditingController textController) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: textController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15.0),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(9.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(9.0),
          ),
          hintText: "Start typing your note...",
          labelStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );