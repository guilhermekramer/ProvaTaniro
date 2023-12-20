import 'package:flutter/material.dart';
import 'package:terceira_prova/domain/Pokemon.dart';
import 'package:terceira_prova/repository/app_database.dart';

class TelaSoltarPokemon extends StatelessWidget {
  final int pokemonId;

  const TelaSoltarPokemon({Key? key, required this.pokemonId}) : super(key: key);

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soltar Pokémon"),
      ),
      body: FutureBuilder<Stream<Pokemon?>>(
        future: carregarPokemon(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os dados do Pokémon'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Pokémon não encontrado'));
          } else {
            Pokemon pokemon = snapshot.data! as Pokemon;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Exibir informações do Pokémon
                  Text("ID: ${pokemon.id}"),
                  Text("Nome: ${pokemon.name}"),
                  // Adicione mais informações conforme necessário

                  // Adicionar imagens do Pokémon se necessário
                  // Image.network(pokemon.imagemUrl),

                  SizedBox(height: 16),

                  // Botões de confirmação e cancelamento
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para confirmar a liberação do Pokémon (delete do banco de dados local)
                          confirmarSoltura(context, pokemon);
                        },
                        child: Text("Confirmar"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para cancelar a operação
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Stream<Pokemon?>> carregarPokemon() async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database').build();
    final pokemonDao = database.pokemonDao;

    return pokemonDao.findPokemonById(pokemonId);
  }

  Future<void> confirmarSoltura(BuildContext context, Pokemon pokemon) async {
    // Lógica para confirmar a liberação do Pokémon (delete do banco de dados local)
    final database = await $FloorAppDatabase.databaseBuilder('app_database').build();
    final pokemonDao = database.pokemonDao;

    pokemonDao.deletePokemon(pokemon).then((_) {
      // Pokémon deletado com sucesso, você pode fazer algo após a confirmação
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pokémon ${pokemon.name} foi solto com sucesso!")),
      );

      // Fecha a tela após a confirmação
      Navigator.pop(context);
    }).catchError((error) {
      // Tratamento de erro, se necessário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao soltar o Pokémon: $error")),
      );
    });
  }
}

