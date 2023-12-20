import 'package:flutter/material.dart';
import 'package:terceira_prova/widgets/appbar_edited.dart';
import 'package:terceira_prova/widgets/tela_captura.dart';
import 'package:terceira_prova/widgets/tela_pokemon_capturado.dart';
import 'package:terceira_prova/widgets/tela_sobre.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  static const IconData pokeIcon = IconData(0xef36, fontFamily: 'MaterialIcons');

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
          home: Builder(
            builder: (context) => Scaffold(
              appBar: const AppbarEdited(),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Text('Pokedex'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.catching_pokemon),
                    title: const Text('Capturar Pokemon'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TelaCaptura(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('Informações'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TelaSobre(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Informações")),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.catching_pokemon_rounded),
                    title: const Text('Pokemons Capturados'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  const TelaPokemonCapturado(),
                        ),
                      );
                      
                    },
                  ),
                ],
              ),
            ),
            body: ElevatedButton(
              onPressed: () {
                // Navegue para a quarta tela
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaCaptura(),
                  ),
                );
              },
              child: const Text('Tela Captura'),
            ),
          ),
        ),
      );
    }


}
