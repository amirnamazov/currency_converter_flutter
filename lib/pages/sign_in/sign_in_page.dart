import 'package:currency_converter/pages/home/cubit/home_page_cubit.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/pages/register_email/cubit/register_email_cubit.dart';
import 'package:currency_converter/pages/register_email/register_email_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'component/sign_in_dialog.dart';

class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      title: Text("Sign in"),
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
              showSignInDialog(context);
            },
            child: Text("Sign in with Email", style: TextStyle(color: Colors.black45),),
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
              GoogleSignIn().signIn().then((value) {
                if (value!.email.isNotEmpty) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => BlocProvider(
                          create: (context) => HomePageCubit(),
                          child: HomePage(),
                        ),
                      ), (Route<dynamic> route) => false
                  );
                }
              });
            },
            child: Text("Sign in with Google"),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15)
            ),
          ),
          SizedBox(height: 15,),
          TextButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => BlocProvider(
                    create: (context) => RegisterEmailCubit(),
                    child: RegisterEmailPage(),
                  ),
                )
            ).then((newAccountCreated) {
              if (newAccountCreated) showSignInDialog(context);
            }),
            child: Text("Create an account"),
          )
        ],
      ),
    ),
  );
}