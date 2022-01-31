import 'package:currency_converter/model/common_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
        if (true) {
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

    }
  }
}