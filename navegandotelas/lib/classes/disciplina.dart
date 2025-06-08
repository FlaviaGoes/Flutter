class Disciplina {
  late final String codigo;
  late final String nome;
  late final String professor;

  Disciplina({required this.codigo, required this.nome, required this.professor});

  static List<Disciplina> gerarDisciplinas() {
    return [
      Disciplina(codigo: 'ALGD1', nome: 'Algoritmos e Programção', professor: 'Ricardo Scheffer'),
      Disciplina(codigo: 'ED1D2', nome: 'Estrutura de Dados I', professor: 'Antonio Dourado'),
      Disciplina(codigo: 'BD1D2', nome: 'Banco de Dados I', professor: 'Marcelo Polido'),
      Disciplina(codigo: 'ED2D3', nome: 'Estrutura de Dados II', professor: 'Antonio Dourado'),
      Disciplina(codigo: 'WEPD3', nome: 'Programação Web', professor: 'Roberta Sinoara'),
      Disciplina(codigo: 'BD2D3', nome: 'Banco de Dados II', professor: 'Marcelo Polido'),
      Disciplina(codigo: 'TP2D5', nome: 'Técnicas de Programação II', professor: 'Felipe Pazinato'),
      Disciplina(codigo: 'PDMDE', nome: 'Programação para Dispositivos Móveis', professor: 'Antonio Dourado')
    ];
  }
}