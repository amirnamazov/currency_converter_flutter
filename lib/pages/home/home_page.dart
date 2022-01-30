import 'package:currency_converter/components/show_signout_modal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Convert"),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () => showSignOutModal(context),
            icon: Icon(Icons.account_circle_outlined),
        )
      ],
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
              child: Text("Sign out")
          )
        ],
      ),
    ),
  );
}