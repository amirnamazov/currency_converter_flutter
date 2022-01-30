import 'package:currency_converter/model/common_state.dart';
import 'package:currency_converter/utils/show_snack_bar.dart';
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
        print("oooooooo " + value.additionalUserInfo!.isNewUser.toString());
        // showSnackBar(context, "ooooooooooo " + value.credential!.token.toString());
      });
    } on FirebaseAuthException catch  (e) {
      emit(ContentState());
      showSnackBar(context, e.message!);
    }
  }
}
