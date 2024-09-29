import 'package:flutter/material.dart';
import 'package:veterinaria_pbd/app_colors.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carnet veterinario',
      theme: ThemeData.light().copyWith(
        extensions: const[AppColors(
          dark: Color(0xFF292b2c),
          light: Color(0xFFf3fefe),
          mainColor: Color.fromARGB(255, 107, 164, 163),
          secondColor: Color(0xFFb4e6e3),
          highlightColor: Color(0xFFd8eceb),
          
        )],
        inputDecorationTheme: InputDecorationTheme(
          /* border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ), */
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 107, 164, 163),
            ),
          ),
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 107, 164, 163),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor:  Color.fromARGB(255, 107, 164, 163),
            foregroundColor: Color(0xff292b2c),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),)
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() { // Función para iniciar sesión. 
  //TODO: Agregar lógica de inicio de sesión aquí, esto es solo un ejemplo con un snackbar.
    final username = _usernameController.text;
    final password = _passwordController.text;

    
    if (username == 'someone' && password == 'password') {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login exitoso')),
      );
    } else {
      // Simula un error de inicio de sesión
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.mainColor,
        title: Text('Carnet veterinario'),
      ),
      body: Padding(
        
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}