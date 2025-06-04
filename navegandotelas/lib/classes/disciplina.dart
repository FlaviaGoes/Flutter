class Disciplina {
  late final String codigo;
  late final String nome;
  late final String professor;

  Disciplina({required this.codigo, required this.nome, required this.professor});

  static List<Disciplina> gerarDisciplinas() {
    return [
      Disciplina(codigo: 'ALGD1', nome: 'Algoritmos e Programção', professor: 'Ricardo Scheffer'),
      Disciplina(codigo: 'ED1D2', nome: 'Estrutura de Dados I', professor: 'Antonio Dourado'),
      Disciplina(codigo: 'BD1D2', nome: 'Banco de Dados I', professor: 'Marcelo Polido')
    ];
  }
}