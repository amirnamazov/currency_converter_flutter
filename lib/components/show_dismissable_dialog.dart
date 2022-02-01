import 'package:flutter/material.dart';

void showDismissableDialog(
    BuildContext context,
    {required String title, required String message}) => showDialog(
    context: context,
    builder: (c) => AlertDialog(
      title: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Text(title,),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                padding: EdgeInsets.all(0),
                splashRadius: 24,
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close)
            ),
          )
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      titlePadding: EdgeInsets.all(10),
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      scrollable: true,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(message),
      ),
    )
);