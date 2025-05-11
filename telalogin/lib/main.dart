
// import 'package:telalogin/classes/login_details.dart';
// import 'package:telalogin/widgets/login_text_field.dart';
// import 'package:telalogin/widgets/tipo_login.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Tela logn',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late TextEditingController _userController;
//   late TextEditingController _senhaController;
//   TiposLogin _tipoCampoLogin = TiposLogin.email;

//   var _senhaEscondida = true;
//   var _tipoLogin = [true, false, false];
//   var _memorizar = false;

//   void _alterarTipoLogin(int idx) {
//     setState(() {
//       _tipoCampoLogin = TiposLogin.values[idx];
//       _tipoLogin =
//           _tipoLogin.mapIndexed((indice, chave) => indice == idx).toList();
//       _userController.text = '';
//     });
//   }

//   void _alterarVisibilidade() {
//     setState(() {
//       _senhaEscondida = !_senhaEscondida;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _userController = TextEditingController();
//     _senhaController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _userController.dispose();
//     _senhaController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(width: 150, 'assets/img/icon.png'),
//             SizedBox(height: 48),
//             TipoLogin(tipoLogin: _tipoLogin, onPressed: _alterarTipoLogin),
//             SizedBox(height: 16),
//             LoginTextField(
//               controller: _userController,
//               tiposLogin: _tipoCampoLogin,
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _senhaController,
//               obscureText: _senhaEscondida,
//               decoration: InputDecoration(
//                 label: Text('Senha'),
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.lock),
//                 suffixIcon: IconButton(
//                   onPressed: _alterarVisibilidade,
//                   icon: Icon(
//                     _senhaEscondida ? Icons.visibility_off : Icons.visibility,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text('aa'),
//                 SizedBox(height: 8),
//                 Switch(
//                   value: _memorizar,
//                   onChanged: (bool) {
//                     setState(() {
//                       _memorizar = !_memorizar;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
