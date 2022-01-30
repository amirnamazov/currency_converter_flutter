import 'package:currency_converter/model/common_state.dart';
import 'package:currency_converter/pages/home/cubit/home_page_cubit.dart';
import 'package:currency_converter/pages/home/home_page.dart';
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
        if (value.additionalUserInfo!.isNewUser) {
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (BuildContext context) => BlocProvider(
          //         create: (context) => HomePageCubit(),
          //         child: HomePage(),
          //       ),
          //     )
          // );
        }
      });
    } on FirebaseAuthException catch  (e) {
      emit(ContentState());
      showSnackBar(context, e.message!);
    }
  }
}
