import 'package:currency_converter/components/custom_text_field.dart';
import 'package:currency_converter/model/common_state.dart';
import 'package:currency_converter/pages/register_email/cubit/register_email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterEmailPage extends StatefulWidget {
  @override
  _RegisterEmailPageState createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends State<RegisterEmailPage> {

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  RegisterEmailCubit? _registerEmailCubit;

  @override
  void didChangeDependencies() {
    _registerEmailCubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up with Email"),
        centerTitle: true,
      ),
      body: BlocBuilder<RegisterEmailCubit, CommonState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator(),);
          } else {
            return _buildContent();
          }
        },
      ),
    );
  }

  Widget _buildContent() => Form(
      key: _globalKey,
      child: ListView(
        padding: EdgeInsets.all(20),
        physics: ClampingScrollPhysics(),
        children: [
          CustomTextField(
            controller: _emailController,
            title: "Email",
            textInputType: TextInputType.emailAddress,
            autofocus: true,
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
          ElevatedButton(
            onPressed: () async {
              if (_globalKey.currentState!.validate()) {
                _registerEmailCubit!.signUpUser(context,
                    email: _emailController.text.trim(),
                    password: _confirmPasswordController.text.trim()
                );
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
  );
}