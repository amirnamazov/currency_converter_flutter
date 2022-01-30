import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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