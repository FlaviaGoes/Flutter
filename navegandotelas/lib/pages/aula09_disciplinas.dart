import 'package:flutter/material.dart';
import 'package:navegandotelas/classes/disciplina.dart';
import 'package:navegandotelas/widgets/disciplina_card.dart';

class Aula09Disciplinas extends StatelessWidget {
  Aula09Disciplinas({super.key});

  final List<Disciplina> disciplinas = Disciplina.gerarDisciplinas();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: disciplinas.length,
      itemBuilder: (context, index) {
        return DisciplinaCard(disciplina: disciplinas[index]);
      }
    );
  }
}