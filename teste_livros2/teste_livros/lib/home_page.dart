import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teste_livros/favoritos.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List> listaLivros;

  @override
  void initState() {
    super.initState();
    listaLivros = baixarLivro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          const Text(
            'Página Inicial',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritosPage()),
              );
            },
            child: Text('Página Favoritos'),
          ),
        ],
      ),
      body: FutureBuilder<List>(
        future: listaLivros,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        snapshot.data![index]['cover_url'],
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                      Text(snapshot.data![index]['id'].toString()),
                      Text(snapshot.data![index]['title']),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.5),
                        child: ConstrainedBox(
                          constraints: BoxConstraints.tightFor(width: 150.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _launchURL(snapshot.data![index]['download_url']);
                            },
                            child: Text('Download'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar dados'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<List> baixarLivro() async {
    var url = Uri.parse('https://escribo.com/books.json');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body).cast<Map<String, dynamic>>().toList();
    }
    throw Exception('Erro ao carregar livro');
  }

  // Função para abrir o URL usando url_launcher
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir $url';
    }
  }
}
