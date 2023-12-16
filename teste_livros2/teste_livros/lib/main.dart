import 'package:flutter/material.dart';
import 'package:teste_livros/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'leitura de eBooks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 96, 183, 58)),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
