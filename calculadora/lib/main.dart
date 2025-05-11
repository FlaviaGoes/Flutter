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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
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
  
  var _contadorPonto = 0;
  var _contadorNumerico = 0;

  void _addInput(String input) {
    setState(() {
      _numbersController.text += input;
      _contadorNumerico++;
    });
  }

  void _addPoint(String input){
    setState(() {
      _numbersController.text += input;

      _contadorPonto++;
    });
  }

  void _removeInput(){
    setState(() {
      String texto = _numbersController.text;

      if(texto.isNotEmpty){
        _numbersController.text = texto.substring(0, texto.length - 1);
        _contadorNumerico--;
      }

      // E se remover o ponto? Não consigo inserir mais?

    });
  }

  void _removeAll(){
    setState(() {
      _numbersController.text = " ";
      _contadorPonto = 0;
      _contadorNumerico = 0;
    });
  }

  void _calcular(){
    setState(() {
      var i = 0;
      var j = 0;
      var idx = 0;
      var x = 0;
      var y = 0;
      var contador = 0;
      double? numero = 0.0;
      var texto = _numbersController.text;
      var auxTexto = "";
      
      List<String> operandos = [];
      List<int> ordem = [];
      List<double> numeros = [];

      for(i=0; i <= texto.length; i++){ //forma que estou lidando com string texto tá errada

        if(texto[i] != '/' && texto[i] != 'X' && texto[i] != '-' && texto[i] != '+'){
          auxTexto += texto[i];
        }

        if(texto[i] == '/' || texto[i] == 'X' || texto[i] == '-' || texto[i] == '+'){
          operandos.add(texto[i]);
          numero = double.tryParse(auxTexto);
          numeros.add(numero ?? 0);
        }
        
      }

      for(i=0; i<=operandos.length; i++){
        if(operandos[i] == 'X'){
          x = 4;
        } else {
          if(operandos[i] == '/'){
            x = 3;
          } else {
            if(operandos[i] == '-'){
              x = 2;
            } else {
              x = 1;
            }
          }
        }
          
        for(j=0; j<=operandos.length; j++){
          if(operandos[j] == 'X'){
            y = 4;
          } else {
            if(operandos[j] == '/'){
              y = 3;
            } else {
              if(operandos[j] == '-'){
                y = 2;
              } else {
                y = 1;
              }
            }
          }

          if(x > y){
            idx = i;
          } else {
            idx = j;
          }
        }
        ordem.add(idx);
      }

      for(i = 0; i<= ordem.length; i++){
        if(operandos[ordem[i]] == "X"){
            for(j = ordem[i]; j <= numeros.length; j++){
              if(contador == 0){
                numeros[j] = numeros[j] * numeros[j++];
                contador++;
              } else {
                numeros[j] = numeros[j++];
              }  
            }
        }
        if(operandos[ordem[i]] == "/"){
            for(j = i; j <= numeros.length; j++){
              if(contador == 0){
                numeros[j] = numeros[j] / numeros[j++];
                contador++;
              } else {
                numeros[j] = numeros[j++];
              }  
            }
        }
        if(operandos[ordem[i]] == "-"){
            for(j = i; j <= numeros.length; j++){
              if(contador == 0){
                numeros[j] = numeros[j] - numeros[j++];
                contador++;
              } else {
                numeros[j] = numeros[j++];
              }  
            }
        }
        if(operandos[ordem[i]] == "+"){
            for(j = i; j <= numeros.length; j++){
              if(contador == 0){
                numeros[j] = numeros[j] + numeros[j++];
                contador++;
              } else {
                numeros[j] = numeros[j++];
              }  
            }
        }
      }

      _numbersController.text = '${numeros[0]}';

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
              height: 100.0,
              decoration: BoxDecoration(
              color: const Color.fromARGB(255, 139, 180, 199),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              border: Border(
                top: BorderSide(color: Colors.white, width: 10.0),
                right: BorderSide(color: Colors.white, width: 10.0),
                left: BorderSide(color: Colors.white, width: 10.0)
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.shade300,
              //     spreadRadius: 1,
              //     blurRadius: 2,
              //     offset: Offset(5, 5),
              //   )
              // ],
            ),
            child: TextField(
                controller: _numbersController,
                readOnly: true,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
              ),
            ),
            Container(
              height: 75.0,
              decoration: BoxDecoration(
              color: const Color.fromARGB(255, 139, 180, 199),
              border: Border(
                right: BorderSide(color: Colors.white, width: 10.0),
                left: BorderSide(color: Colors.white, width: 10.0)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(5, 0),
                )
              ],
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
                    onPressed: _contadorPonto == 1 ? null : () => _addPoint(botoesString[Botoes.ponto] ?? ''),
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
                right: BorderSide(color: Colors.white, width: 10.0),
                left: BorderSide(color: Colors.white, width: 10.0)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(5, 0),
                )
              ],
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
                    onPressed: null,
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
                right: BorderSide(color: Colors.white, width: 10.0),
                left: BorderSide(color: Colors.white, width: 10.0)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(5, 0),
                )
              ],
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
                    onPressed: null,
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
                right: BorderSide(color: Colors.white, width: 10.0),
                left: BorderSide(color: Colors.white, width: 10.0)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(5, 0),
                )
              ],
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
                    onPressed: null,
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
                right: BorderSide(color: Colors.white, width: 10.0),
                left: BorderSide(color: Colors.white, width: 10.0)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(5, 0),
                )
              ],
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
                    onPressed: () => _addInput(botoesString[Botoes.dividir] ?? ''),
                    child: Text(botoesString[Botoes.dividir] ?? ''),
                  ),
                  SizedBox(width: 30),
                ],
              ),
            ),
          ],
        )
      );  
  }
}
