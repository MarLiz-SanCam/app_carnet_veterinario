import 'package:flutter/material.dart';
import 'package:veterinaria_pbd/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        inputDecorationTheme: const InputDecorationTheme(
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
            backgroundColor:  const Color.fromARGB(255, 107, 164, 163),
            foregroundColor: const Color(0xff292b2c),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),)
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://tu_api_url/login'), // Cambia esto a la URL de tu API
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Manejar la respuesta, por ejemplo:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bienvenid@ ${data['username']}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Revise su usuario y contraseña')),
      );
    }
  }

  void _loginButtonPressed() async {
    await _login(); // Llama a la función para iniciar sesión
  }

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.mainColor,
        title: const Text('Carnet veterinario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _loginButtonPressed, // Cambia aquí
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
