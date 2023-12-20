import 'package:flutter/material.dart';
import 'package:terceira_prova/domain/Pokemon.dart';
import 'package:terceira_prova/repository/app_database.dart';

class TelaPokemonCapturado extends StatelessWidget {
const TelaPokemonCapturado({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokémons Capturados"),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: pegaPokemons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro ao carregar os Pokémon');
          } else {
            List<Pokemon> pokemons = snapshot.data ?? [];

            return ListView.builder(
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = pokemons[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDetalhesPokemon(pokemon: pokemon),
                      ),
                    );
                  },
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaSoltarPokemon(pokemon: pokemon),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text("Nome: ${pokemon.name}"),
                    subtitle: Text("Número: ${pokemon.id}"),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Pokemon>> pegaPokemons() async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database').build();
    final pokemonDao = database.pokemonDao;

    return pokemonDao.findAllPokemon();
  }
}

class TelaDetalhesPokemon extends StatelessWidget {
  final Pokemon pokemon;

  const TelaDetalhesPokemon({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Pokémon"),
      ),
      body: Center(
        child: Text("Detalhes do Pokémon: ${pokemon.name}"),
      ),
    );
  }
}

class TelaSoltarPokemon extends StatelessWidget {
  final Pokemon pokemon;

  const TelaSoltarPokemon({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soltar Pokémon"),
      ),
      body: Center(
        child: Text("Soltar Pokémon: ${pokemon.name}"),
      ),
    );
  }
}