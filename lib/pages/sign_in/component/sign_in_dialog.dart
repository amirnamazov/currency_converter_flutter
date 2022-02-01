import 'package:currency_converter/components/custom_text_field.dart';
import 'package:currency_converter/constants/const_shared_preference.dart';
import 'package:currency_converter/model/common_state.dart';
import 'package:currency_converter/pages/sign_in/cubit/sign_in_cubit.dart';
import 'package:currency_converter/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showSignInDialog(BuildContext context) async {

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final SharedPreferences sharedPreferences = locator.get();
  String? email = await sharedPreferences.getString(kEmail);
  if (email != null) {
    _emailController.text = email;
  }

  showDialog(
      context: context,
      builder: (c) => BlocProvider(
        create: (context) => SignInCubit(),
        child: AlertDialog(
          title: Text("Sign in with email", textAlign: TextAlign.center,),
          contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          titlePadding: EdgeInsets.all(10),
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          scrollable: true,
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: BlocBuilder<SignInCubit, CommonState>(
              builder: (context, state) {
                return Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          title: "Email",
                          textInputType: TextInputType.emailAddress,
                          autofocus: email != null ? false : true,
                        ),
                        SizedBox(height: 20,),
                        CustomTextField(
                          controller: _passwordController,
                          title: "Password",
                          textInputType: TextInputType.visiblePassword,
                          autofocus: email != null ? true : false,
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                          onPressed: () async {
                            if (_globalKey.currentState!.validate()) {
                              SignInCubit _signInCubit = BlocProvider.of(context);
                              _signInCubit.signInUser(context,
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim()
                              );
                            }
                          },
                          child: Container(
                              height: 20,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: state is LoadingState
                                  ? SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),)
                                  : Text("Sign in")
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(15)
                          ),
                        )
                      ],
                    )
                );
              },
            ),
          ),
        ),
      )
  );
}