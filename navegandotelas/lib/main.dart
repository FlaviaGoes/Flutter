import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navegandotelas/classes/login_details.dart';
import 'package:navegandotelas/pages/aula09.dart';
import 'package:navegandotelas/pages/aula09_dashboard.dart';
import 'package:navegandotelas/pages/aula09_disciplinas.dart';
import 'package:navegandotelas/widgets/login_text_field.dart';
import 'package:navegandotelas/widgets/tipo_login.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _dashboardNavigatorKey = GlobalKey<NavigatorState>();
final _disciplinaNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      // Tela Login
      GoRoute(
        path: '/',
        builder: (context, state) => const MyHomePage(),
      ),

      //Shell com abas da Aula09
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          final args = state.extra as Map<String, String>?;
          final usuario = args?['usuario'] ?? '';
          return Aula09(usuario: usuario, navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _dashboardNavigatorKey,
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) {
                  final args = state.extra as Map<String, String>?;
                  final usuario = args?['usuario'] ?? '';
                  return Aula09Dashboard(usuario: usuario);
                },
              )
            ]
          ),
          StatefulShellBranch(
            navigatorKey: _disciplinaNavigatorKey,
            routes: [
              GoRoute(
                path: '/disciplinas',
                builder: (context, state) => Aula09Disciplinas(),
              )
            ]
          )
        ]
      ),
      // GoRoute(
      //   path: '/aula09',
      //   builder: (context, state) {
      //     final args = state.extra as Map<String, String>?;
      //     final usuario = args?['usuario'] ?? '';
      //     return Aula09(usuario: usuario);
      //   }
      // )
    ]
  );

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Tela Login',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      routerConfig: _router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _userController;
  late TextEditingController _senhaController;
  TiposLogin _tipoCampoLogin = TiposLogin.usuario;

  var _senhaEscondida = true;
  var _tipoLogin = [true, false, false];
  var _memorizar = false;

  void _alterarTipoLogin(int idx){
    setState(() {
      _tipoCampoLogin = TiposLogin.values[idx];
      _tipoLogin = _tipoLogin.asMap().entries.map((entry) => entry.key == idx).toList();
      _userController.text = '';
    });
  }

  void _alterarVisibilidade(){
    setState(() {
      _senhaEscondida = !_senhaEscondida;
    });
  }

  @override
  void initState(){
    super.initState();
    _userController = TextEditingController();
    _senhaController = TextEditingController();
  }

  @override
  void dispose(){
    _userController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(width: 200, 'assets/img/icon.png'),
              SizedBox(height: 48),
              TipoLogin(tipoLogin: _tipoLogin, onPressed: _alterarTipoLogin),
              SizedBox(height: 16),
              LoginTextField(controller: _userController, tiposLogin: _tipoCampoLogin),
              SizedBox(height: 16),
              TextField(
                controller: _senhaController,
                obscureText: _senhaEscondida,
                decoration: InputDecoration(
                  label: Text('Senha'),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: _alterarVisibilidade,
                    icon: Icon(
                      _senhaEscondida ? Icons.visibility_off : Icons.visibility
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Memorizar'),
                  SizedBox(height: 8),
                  Switch(
                    value: _memorizar,
                    onChanged: (boo){
                      setState(() {
                        _memorizar = !_memorizar;
                      });
                    }
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if(_userController.text.isNotEmpty && _senhaController.text == 'admin') {
                    context.go('/dashboard', extra: {'usuario': _userController.text});
                  } else {
                    showDialog(
                      context: context, 
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Atenção'),
                          content: const Text('Preencha os campos corretamente.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context), 
                              child: const Text('OK')),
                          ],
                        );
                      }
                    );
                  }
                },
                child: const Text('Login'),
              )
            ],
          ),
        )
      ),
    );
  }
}
