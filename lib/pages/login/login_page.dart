import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Registration"),
      centerTitle: true,
    ),
    body: Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {

            },
            child: Text("Sign up with Email", style: TextStyle(color: Colors.black45),),
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black45,
                side: BorderSide(color: Colors.black45)
            ),
          ),
          ElevatedButton(
              onPressed: () {

              },
              child: Text("Sign up with Google")
          )
        ],
      ),
    ),
  );
}