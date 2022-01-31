import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {

  CustomTextField({
    required this.controller,
    required this.title,
    this.textInputType = TextInputType.text,
    this.passwordControllers,
    this.autofocus = false
  });

  final TextEditingController controller;
  final String title;
  final TextInputType textInputType;
  final List<TextEditingController>? passwordControllers;
  final bool autofocus;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: widget.controller,
    keyboardType: widget.textInputType,
    obscureText: widget.textInputType == TextInputType.visiblePassword ? true : false,
    autofocus: widget.autofocus,
    decoration: InputDecoration(
      labelText: widget.title,
      contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return "Fill the gap!";
      } else if (widget.textInputType == TextInputType.emailAddress) {
        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value.trim())){
          return "Email format is not correct!";
        }
      } else if (widget.passwordControllers != null && widget.passwordControllers!.isNotEmpty) {
        if (widget.passwordControllers![0].text != widget.passwordControllers![1].text) {
          return "Passwords do not match!";
        }
      }
      else return null;
    },
  );
}