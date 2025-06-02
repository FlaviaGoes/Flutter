import 'package:flutter/material.dart';
import 'package:navegandotelas/classes/login_details.dart';

class LoginTextField extends StatefulWidget {
  final TextEditingController controller;
  final TiposLogin tiposLogin;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.tiposLogin,
  });

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();

}

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    var loginMap = LoginDetails.loginDetails();

    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        label: Text(loginMap[widget.tiposLogin]!.label),
        hintText: loginMap[widget.tiposLogin]!.hint,
        prefix: loginMap[widget.tiposLogin]!.prefixIcon
      )
    );
  }
}

