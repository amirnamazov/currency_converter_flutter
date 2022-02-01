import 'package:currency_converter/constants/const_shared_preference.dart';
import 'package:currency_converter/pages/sign_in/sign_in_page.dart';
import 'package:currency_converter/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showSignOutModal(BuildContext context) async {

  final SharedPreferences sharedPreferences = locator.get();
  final bool isEmailSignedIn = await sharedPreferences.getString(kToken) != null
      && await sharedPreferences.getString(kToken)!.isNotEmpty;
  String email = "";

  if (isEmailSignedIn) {
    email = await sharedPreferences.getString(kEmail)!;
  } else {
    email = await sharedPreferences.getString(kGoogleEmail)!;
  }

  navigateToSignInPage () => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SignInPage(),
      ), (Route<dynamic> route) => false
  );

  signOut () async {
    if (isEmailSignedIn) {
      await sharedPreferences.setString(kToken, "");
      navigateToSignInPage();
    } else {
      GoogleSignIn().signOut().whenComplete(() => navigateToSignInPage());
    }
  }

  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (c) => Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(email),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () => signOut(),
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
}