import 'package:flutter/material.dart';
import 'package:navegandotelas/classes/disciplina.dart';

class DisciplinaCard extends StatelessWidget {
  const DisciplinaCard({super.key, required this.disciplina});

  final Disciplina disciplina;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Center(
                child: Text(disciplina.codigo),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(disciplina.nome),
                Text(disciplina.professor),
              ],
            )
          ],
        ),
      ),
    );
  }
}