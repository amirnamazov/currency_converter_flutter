import 'package:currency_converter/components/show_dismissable_dialog.dart';
import 'package:currency_converter/model/common_state.dart';
import 'package:currency_converter/pages/home/cubit/home_page_cubit.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<CommonState> {
  SignInCubit() : super(ContentState());

  void signInUser(BuildContext context, {required String email, required String password}) async {
    try {
      emit(LoadingState());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) {
        emit(ContentState());
        if (value.user != null) {
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