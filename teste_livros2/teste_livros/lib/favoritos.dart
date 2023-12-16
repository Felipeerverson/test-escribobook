import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({Key? key}) : super(key: key);

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  late Future<List<Map<String, dynamic>>> listaLivros;
  final List<Map<String, dynamic>> _listaFavoritos = [];

  @override
  void initState() {
    super.initState();
    listaLivros = baixarLivro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Página Favoritos',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: listaLivros,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final livro = snapshot.data![index];
                final isFavorito = _listaFavoritos.contains(livro);

                return Container(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        livro['cover_url'],
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                      Text(livro['id'].toString()),
                      Text(livro['title']),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.5),
                        child: ConstrainedBox(
                          constraints:
                              const BoxConstraints.tightFor(width: 150.0),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (isFavorito) {
                                  _listaFavoritos.remove(livro);
                                } else {
                                  _listaFavoritos.add(livro);
                                }
                              });
                            },
                            icon: isFavorito
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(Icons.favorite_border),
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

  Future<List<Map<String, dynamic>>> baixarLivro() async {
    var url = Uri.parse('https://escribo.com/books.json');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body).cast<Map<String, dynamic>>();
    }
    throw Exception('Erro ao carregar livro');
  }
}
