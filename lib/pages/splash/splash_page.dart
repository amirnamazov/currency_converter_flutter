import 'package:currency_converter/pages/sign_in/sign_in_page.dart';
import 'package:currency_converter/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();
    locator.allReady().then((value) => {
      Future.delayed(const Duration(milliseconds: 800), () async {
        sharedPreferences = locator.get();
        // if (sharedPreferences!.getString(kToken) == null) {
        //   openStartPage();
        // } else {
        //   fetchTerms();
        // }
        openStartPage();
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text("dddddddddd"),
        ),
      ),
    );
  }

  openStartPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SignInPage(),
        )
    );
  }

  /*Future<void> fetchTerms() async {
    InternetConnection.check().then((value) async {
      if (value) {
        await RequestClient().get(
          endPoint: RequestApi.terms,
          onSuccess: (statusCode, response) {
            TermsModel termsModel = TermsModel.fromJson(json.decode(response!));
            kTerms = termsModel.parsedContent!;
            fetchSettings();
          },
          onFailure: (statusCode, response) {
            openStartPage();
          },
          onError: () {
            openStartPage();
          },
        );
      }
    });
  }

  Future<void> fetchSettings() async {
    InternetConnection.check().then((value) {
      if (value) {
        RequestClient().get(
          endPoint: RequestApi.settings,
          onSuccess: (statusCode, response) {
            SettingsModel settingsModel =
                SettingsModel.fromJson(json.decode(response!));

            locator.registerLazySingleton<SettingsModel>(() => settingsModel);
            openMainPage();
          },
          onFailure: (statusCode, response) {},
          onError: () {},
        );
      }
    });
  }*/
}
