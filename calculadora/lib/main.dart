import 'package:calculadora/tipos_botoes.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 139, 180, 199)),
      ),
      home: const MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});
  

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  late TextEditingController _numbersController;
  
  var _contadorInputs = 0;
  var _contadorPonto = 0;
   

  void _addInput(String input) {
    setState(() {

      if(_contadorInputs <= 20){
          _numbersController.text += input;
          _contadorInputs++;
      }
      
    });
  }

  void _addPoint(String input){
    setState(() {
      String texto = _numbersController.text;

      if (_contadorPonto == 0 && (_contadorInputs > 0 && _contadorInputs < 20) && !"+-x/.".contains(texto[texto.length - 1])) {
        _numbersController.text += input;
        _contadorInputs++;
        _contadorPonto++;
      }

    });
  }

  void _addOperador(String input){
    setState(() {

      String texto = _numbersController.text;

      if("1234567890".split('').any((op) => texto.contains(op))) {
        if (!"+-x/.".contains(texto[texto.length - 1])) {
          _numbersController.text += input;
          _contadorInputs++;
          _contadorPonto--;
        }
      }

      
    });
  }

  void _removeInput(){
    setState(() {
      String texto = _numbersController.text;
      String ultCaractere;

      if(texto.isNotEmpty){
        ultCaractere = texto[texto.length - 1]; 
        _numbersController.text = texto.substring(0, texto.length - 1);
        _contadorInputs--;

        if(ultCaractere == "."){
          _contadorPonto = 0;
        }
      }

    });
  }

  void _removeAll(){
    setState(() {
      _numbersController.text = " ";
      _contadorInputs = 0;
      _contadorPonto = 0;
    });
  }

  void _calcular(){
    setState(() {

      String texto = _numbersController.text;
      String auxTexto = "";

      List<String> operandos = [];
      List<double> numeros = [];

      double? numero = 0;
      double resultado = 0;

      if (texto.isNotEmpty && !"+-x/.".contains(texto[texto.length - 1]) && "+-x/".split('').any((op) => texto.contains(op))) {

        //Separando números e operadores
        for(int i = 0; i < texto.length; i++){
          if("+-x/".contains(texto[i]) && !(i == 0)){
            operandos.add(texto[i]);
            numero = double.tryParse(auxTexto);
            numeros.add(numero ?? 0);
            auxTexto = "";
          } else {
            auxTexto += texto[i];
          }
        }

        //Adiciona último número
        if(auxTexto.isNotEmpty) {
          numero = double.tryParse(auxTexto);
          numeros.add(numero ?? 0);
        }

        //Multi e divisao
        for(int i = 0; i < operandos.length; i++){
          if(operandos[i] == "x" || operandos[i] == "/"){
            resultado = operandos[i] == "x" ? numeros[i] * numeros[i + 1] : numeros[i] / numeros[i + 1];

            numeros.removeAt(i + 1);
            operandos.removeAt(i);
            numeros[i] = resultado;
            i--; // Volta uma posição porque a lista foi reduzida
          }
        }

        // Soma e sub
        for(int i = 0; i < operandos.length; i++){
          resultado = operandos[i] == "+" ? numeros[i] + numeros[i + 1] : numeros[i] - numeros[i + 1];

          numeros.removeAt(i + 1);
          operandos.removeAt(i);
          numeros[i] = resultado;
          i--;
        }

        //Resultado final
        if (numeros.isNotEmpty && numeros[0] != double.infinity) {
          _numbersController.text = numeros[0].toStringAsFixed(2);
        } else {
          _numbersController.text = 'Erro: Não é possível dividir por zero';
        }

        numeros.clear();
        _contadorInputs = 0;
      }
    });
  }

  @override
  void initState(){
    super.initState();
    _numbersController = TextEditingController();
  }

  @override
  void dispose(){
    super.dispose();
    _numbersController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              height: 130.0,
              decoration: BoxDecoration(
              color: const Color.fromARGB(255, 139, 180, 199),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              border: Border(
                top: BorderSide(color: Colors.white, width: 5.0),
                right: BorderSide(color: Colors.white, width: 5.0),
                left: BorderSide(color: Colors.white, width: 5.0)
              ),
            ),
            child: TextField(
                controller: _numbersController,
                readOnly: true,
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 28),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
            ),
            Container(
              height: 75.0,
              decoration: BoxDecoration(
              color: const Color.fromARGB(255, 139, 180, 199),
              border: Border(
                right: BorderSide(color: Colors.white, width: 5.0),
                left: BorderSide(color: Colors.white, width: 5.0)
              ),
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _removeAll(), 
                    child: Text(botoesString[Botoes.apagarTudo] ?? '')
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _addInput(botoesString[Botoes.zero] ?? ''),
                    child: Text(botoesString[Botoes.zero] ?? ''),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _addPoint(botoesString[Botoes.ponto] ?? ''),
                    child: Text(botoesString[Botoes.ponto] ?? ''),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _removeInput(),
                    child: Icon(Icons.backspace_outlined),
                  ),
                ],
              ),
            ),
            Container(
              height: 75.0,
              decoration: BoxDecoration(
              color: const Color.fromARGB(255, 139, 180, 199),
              border: Border(
                right: BorderSide(color: Colors.white, width: 5.0),
                left: BorderSide(color: Colors.white, width: 5.0)
              ),
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _addInput(botoesString[Botoes.seven] ?? ''), 
                    child: Text(botoesString[Botoes.seven] ?? '')
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _addInput(botoesString[Botoes.eigth] ?? ''),
                    child: Text(botoesString[Botoes.eigth] ?? ''),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _addInput(botoesString[Botoes.nine] ?? ''),
                    child: Text(botoesString[Botoes.nine] ?? ''),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _addOperador(botoesString[Botoes.multiplicar] ?? ''),
                    child: Text(botoesString[Botoes.multiplicar] ?? ''),
                  ),
                ],
              ),
            ),
            Container(
              height: 75.0,
              decoration: BoxDecoration(
              color: const Color.fromARGB(255, 139, 180, 199),
              border: Border(
                right: BorderSide(color: Colors.white, width: 5.0),
                left: BorderSide(color: Colors.white, width: 5.0)
              ),
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _addInput(botoesString[Botoes.four] ?? ''), 
                    child: Text(botoesString[Botoes.four] ?? '')
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _addInput(botoesString[Botoes.five] ?? ''),
                    child: Text(botoesString[Botoes.five] ?? ''),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _addInput(botoesString[Botoes.six] ?? ''),
                    child: Text(botoesString[Botoes.six] ?? ''),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 30)
                    ),
                    onPressed: () => _addOperador(botoesString[Botoes.subtrair] ?? ''),
                    child: Text(botoesString[Botoes.subtrair] ?? ''),
                  ),
                ],
              ),
            ),
            Container(
              height: 75.0,
              decoration: BoxDecoration(
              color: const Color.fromARGB(255, 139, 180, 199),
              border: Border(
                right: BorderSide(color: Colors.white, width: 5.0),
                left: BorderSide(color: Colors.white, width: 5.0)
              ),
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _addInput(botoesString[Botoes.one] ?? ''), 
                    child: Text(botoesString[Botoes.one] ?? '')
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _addInput(botoesString[Botoes.two] ?? ''),
                    child: Text(botoesString[Botoes.two] ?? ''),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _addInput(botoesString[Botoes.three] ?? ''),
                    child: Text(botoesString[Botoes.three] ?? ''),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 17)
                    ),
                    onPressed: () => _addOperador(botoesString[Botoes.somar] ?? ''),
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Container(
              height: 75.0,
              decoration: BoxDecoration(
              color: const Color.fromARGB(255, 139, 180, 199),
              border: Border(
                right: BorderSide(color: Colors.white, width: 5.0),
                left: BorderSide(color: Colors.white, width: 5.0),
                bottom: BorderSide(color: Colors.white, width: 5.0)
              ),
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(160, 50),
                      textStyle: TextStyle(fontSize: 30)
                    ),
                    onPressed: () => _calcular(),
                    child: Text(botoesString[Botoes.calcular] ?? ''),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      minimumSize: Size(75, 50),
                      textStyle: TextStyle(fontSize: 30)
                    ),
                    onPressed: () => _addOperador(botoesString[Botoes.dividir] ?? ''),
                    child: Text(botoesString[Botoes.dividir] ?? ''),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ],
        )
      );  
  }
}
