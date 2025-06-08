
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Aula09 extends StatelessWidget {
  final String usuario;
  final StatefulNavigationShell navigationShell;

  const Aula09({super.key, required this.usuario, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        currentIndex: navigationShell.currentIndex,
        items: const [
          BottomNavigationBarItem(label: 'Dashboard', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Disciplinas', icon: Icon(Icons.menu_open)),
          BottomNavigationBarItem(label: 'Sair', icon: Icon(Icons.logout)),
        ],
        onTap: (index) async {
          if(index == 2) {
            final resultado = await showDialog(
              context: context, 
              builder: (context) => AlertDialog(
                title: Text('Atenção'),
                content: Text('Deseja continuar para a tela de login?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, true), 
                    child: Text('CONTINUAR'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, false), 
                    child: Text('CANCELAR')),
                ],
              ),
            );
            if(context.mounted && resultado == true){
              context.go('/'); // volta ao login
            }
          } else {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          }
        },
      ),
    );
  }
}