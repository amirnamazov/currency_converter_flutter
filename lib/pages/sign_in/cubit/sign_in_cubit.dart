import 'package:currency_converter/components/show_dismissable_dialog.dart';
import 'package:currency_converter/constants/const_shared_preference.dart';
import 'package:currency_converter/model/common_state.dart';
import 'package:currency_converter/pages/home/cubit/home_page_cubit.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInCubit extends Cubit<CommonState> {
  SignInCubit() : super(ContentState());

  final SharedPreferences sharedPreferences = locator.get();

  void signInUser(BuildContext context, {required String email, required String password}) async {
    try {
      emit(LoadingState());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) {
        emit(ContentState());
        if (value.user != null) {
          value.user!.getIdToken().then((val) async => await sharedPreferences.setString(kToken, val));
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
    } on FirebaseAuthException catch  (e) {
      emit(ContentState());
      showDismissableDialog(context, title: "Sign in failed", message: e.message!);
    }
  }
}