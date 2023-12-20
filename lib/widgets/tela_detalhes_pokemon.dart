import 'package:flutter/material.dart';
import 'package:terceira_prova/domain/Pokemon.dart';
import 'package:terceira_prova/repository/app_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TelaDetalhesPokemon extends StatelessWidget {
  final int pokemonId;

  const TelaDetalhesPokemon({Key? key, required this.pokemonId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Pokémon"),
      ),
      body: FutureBuilder<Stream<Pokemon?>>(
        future: carregarDadosBancoDeDadosStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os dados do banco de dados'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Dados do Pokémon não encontrados no banco de dados'));
          } else {
            return StreamBuilder<Pokemon?>(
              stream: snapshot.data,
              builder: (context, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (streamSnapshot.hasError) {
                  return Center(child: Text('Erro ao carregar os dados do banco de dados'));
                } else if (!streamSnapshot.hasData || streamSnapshot.data == null) {
                  return Center(child: Text('Dados do Pokémon não encontrados no banco de dados'));
                } else {
                  Pokemon pokemonLocal = streamSnapshot.data!;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Exibir informações do Pokémon a partir dos dados do banco de dados
                        Text("ID (Banco de Dados): ${pokemonLocal.id}"),
                        Text("Tipo (Banco de Dados): ${pokemonLocal.name}"),
                        // Adicione mais informações conforme necessário
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Future<Stream<Pokemon?>> carregarDadosBancoDeDadosStream() async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database').build();
    final pokemonDao = database.pokemonDao;

    // Suponha que a função getStreamPokemonById retorna Stream<Pokemon>
    return pokemonDao.findPokemonById(pokemonId);
  }
}