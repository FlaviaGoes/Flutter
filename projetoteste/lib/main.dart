import 'package:flutter/material.dart';

void main() {
  runApp(const HelloWorldWidget());
}

class HelloWorldWidget extends StatelessWidget{
  const HelloWorldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Primeiro App',
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Widget 1'),
                SizedBox(width: 25),
                Text('Widget 2')
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Widget 3'),
                SizedBox(width: 25),
                Text('Widget 4')
              ],
            )
          ],
        )
      )
    );
  }
}

