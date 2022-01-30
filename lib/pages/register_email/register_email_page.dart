import 'package:currency_converter/components/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterEmailPage extends StatelessWidget {

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Sign up with Email"),
      centerTitle: true,
    ),
    body: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Form(
              key: _globalKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailController,
                    title: "Email",
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20,),
                  CustomTextField(
                    controller: _passwordController,
                    title: "Password",
                    textInputType: TextInputType.visiblePassword,
                    passwordControllers: [_passwordController, _confirmPasswordController],
                  ),
                  SizedBox(height: 20,),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    title: "Confirm Password",
                    textInputType: TextInputType.visiblePassword,
                    passwordControllers: [_passwordController, _confirmPasswordController],
                  ),
                  SizedBox(height: 20,),
                ],
              )
          ),
          ElevatedButton(
            onPressed: () {
              if (_globalKey.currentState!.validate()) {

              }
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text("Sign up"),
            ),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15)
            ),
          )
        ],
      )
    ),
  );
}