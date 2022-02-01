import 'package:currency_converter/constants/const_shared_preference.dart';
import 'package:currency_converter/model/common_state.dart';
import 'package:currency_converter/components/show_snack_bar.dart';
import 'package:currency_converter/utils/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterEmailCubit extends Cubit<CommonState> {
  RegisterEmailCubit() : super(ContentState());

  final SharedPreferences sharedPreferences = locator.get();

  void signUpUser(BuildContext context, {required String email, required String password}) async {
    try {
      emit(LoadingState());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) async {
        emit(ContentState());
        if (value.additionalUserInfo!.isNewUser) {
          value.user!.getIdToken().then((val) async => await sharedPreferences.setString(kToken, val));
          if (value.user!.email != null) {
            await sharedPreferences.setString(kEmail, value.user!.email!);
          }

          showSnackBar(context, "Account created successfully!");
          Navigator.pop(context, true);
        }
      });

    } on FirebaseAuthException catch  (e) {
      emit(ContentState());
      showSnackBar(context, e.message!);
    }
  }
}