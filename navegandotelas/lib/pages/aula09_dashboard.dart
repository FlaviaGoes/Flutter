import 'package:flutter/material.dart';
import 'package:navegandotelas/classes/disciplina.dart';
import 'package:navegandotelas/widgets/disciplina_card.dart';

class Aula09Dashboard extends StatelessWidget {
  const Aula09Dashboard({super.key, required this.usuario});

  final String usuario; 

  @override
  Widget build(BuildContext context) {

    final List<Disciplina> disciplinas = List.from(Disciplina.gerarDisciplinas())..shuffle(); // cria uma copia e embaralha
    final int quantidade = 4; //qtd de disciplinas aleatórias

    final List<Disciplina> selecionadas = disciplinas.take(quantidade).toList();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Bem vindo $usuario',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            'Disciplinas sugeridas para você :)',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: selecionadas.length,
              itemBuilder: (context, index){
                return DisciplinaCard(disciplina: selecionadas[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}