import 'package:flutter/material.dart';

void showSignInDialog(BuildContext context) => showDialog(
    context: context,
    builder: (c) => AlertDialog(
      title: Text("Sign in with email", textAlign: TextAlign.center,),
      contentPadding: EdgeInsets.all(10),
      titlePadding: EdgeInsets.all(10),
      content: Container(
        child: Text("saknsakj "),
      ),
    )
);