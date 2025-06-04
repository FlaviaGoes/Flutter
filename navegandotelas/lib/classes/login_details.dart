import 'package:flutter/material.dart';

enum TiposLogin {usuario, email, cpf}

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
      TiposLogin.usuario: LoginDetails(
        hint: 'Nome',
        label: 'Usuario',
        prefixIcon: Icon(Icons.person),
      ),
      TiposLogin.email: LoginDetails(
        hint: 'example@gmail.com',
        label: 'E-mail',
        prefixIcon: Icon(Icons.email),
      ),
      TiposLogin.cpf: LoginDetails(
        hint: 'xxx.xxx.xxx-xx',
        label: 'CPF',
        prefixIcon: Icon(Icons.phone),
      )
    };
  }
}