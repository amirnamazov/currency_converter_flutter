import 'package:currency_converter/pages/register_email/register_email_cubit.dart';
import 'package:currency_converter/pages/register_email/register_email_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => BlocProvider(
                      create: (context) => RegisterEmailCubit(),
                      child: RegisterEmailPage(),
                    ),
                  )
              );
            },
            child: Text("Sign up with Email", style: TextStyle(color: Colors.black45),),
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black45,
                side: BorderSide(color: Colors.black45),
                padding: EdgeInsets.all(15)
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
              onPressed: () {

              },
              child: Text("Sign up with Google"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(15)
            ),
          )
        ],
      ),
    ),
  );
}