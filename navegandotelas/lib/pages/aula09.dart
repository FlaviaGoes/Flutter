
import 'package:flutter/material.dart';

class Aula09 extends StatefulWidget {

  const Aula09({super.key});

  @override
  State<Aula09> createState() => _Aula09State();
}

class _Aula09State extends State<Aula09> {

  var _itemSelecionado = 0;

  @override
  Widget build(BuildContext context) {

    var args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => {},
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.green,
          selectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(label: 'Dashboard', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: 'Disciplinas', icon: Icon(Icons.menu_open)),
            BottomNavigationBarItem(label: 'Sair', icon: Icon(Icons.logout)),
          ],
          currentIndex: _itemSelecionado,
          onTap: (idx) {
            setState(() {
              if(idx == 2) {
                Navigator.pop(context);
              }
              _itemSelecionado = idx;
            });
          },
        )
      ),
    );
  }
}