import 'package:flutter/material.dart';

enum TiposLogin {email, cpf, telefone}

class LoginDetails {
  late final String hint;
  late final String label;
  late final Icon prefixIcon;

  LoginDetails({
    required this.hint,
    required this.label,
    required this.prefixIcon,
  });

  // É um método estático para a classe não precisar ser instanciada
  static Map<TiposLogin, LoginDetails> loginDetails(){
    return {
      TiposLogin.cpf: LoginDetails(
        hint: '111.111.111-11',
        label: 'CPF',
        prefixIcon: Icon(Icons.person),
      ),
      TiposLogin.email: LoginDetails(
        hint: 'example@gmail.com',
        label: 'E-mail',
        prefixIcon: Icon(Icons.email),
      ),
      TiposLogin.telefone: LoginDetails(
        hint: '(xx) xxxxx-xxxx',
        label: 'Telefone',
        prefixIcon: Icon(Icons.phone),
      )
    };
  }
}