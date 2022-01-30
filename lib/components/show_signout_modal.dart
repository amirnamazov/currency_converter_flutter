import 'package:flutter/material.dart';

void showSignOutModal(BuildContext context) => showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (c) => Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("amirnamazov3@gmail.com"),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () async {

            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text("Sign out"),
            ),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15)
            ),
          )
        ],
      ),
    )
);