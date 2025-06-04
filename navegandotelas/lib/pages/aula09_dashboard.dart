import 'package:flutter/material.dart';

class Aula09Dashboard extends StatelessWidget {
  const Aula09Dashboard({super.key, required this.usuario});

  final String usuario; 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Bem vindo $usuario'),
        ],
      ),
    );
  }
}