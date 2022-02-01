import 'package:currency_converter/model/common_state.dart';
import 'package:currency_converter/components/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterEmailCubit extends Cubit<CommonState> {
  RegisterEmailCubit() : super(ContentState());

  void signUpUser(BuildContext context, {required String email, required String password}) async {
    try {
      emit(LoadingState());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) {
        emit(ContentState());
        if (value.additionalUserInfo!.isNewUser) {
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
