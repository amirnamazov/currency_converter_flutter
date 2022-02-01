import 'package:currency_converter/components/show_snack_bar.dart';
import 'package:currency_converter/constants/const_shared_preference.dart';
import 'package:currency_converter/pages/home/cubit/home_page_cubit.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/pages/sign_in/sign_in_page.dart';
import 'package:currency_converter/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    locator.allReady().then((value) => {
      Future.delayed(Duration(milliseconds: 1000), () async {
        final SharedPreferences sharedPreferences = locator.get();
        if (await sharedPreferences.getString(kToken) != null
            && await sharedPreferences.getString(kToken)!.isNotEmpty) {
          _openHomePage();
        } else {
          _checkGoogleSigneIn();
        }
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          "Currency Converter",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30
          ),
        ),
      )
    );
  }

  void _checkGoogleSigneIn() {
    GoogleSignIn().isSignedIn().then((isSignedIn) {
      if (isSignedIn) {
        _openHomePage();
      } else {
        _openSignInPage();
      }
    });
  }

  void _openSignInPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SignInPage(),
        ), (Route<dynamic> route) => false
    );
  }

  void _openHomePage() {
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
}
