import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:terceira_prova/domain/Pokemon.dart';
import 'package:terceira_prova/repository/app_database.dart';
import 'package:terceira_prova/widgets/appbar_edited.dart';



class TelaCaptura extends StatefulWidget {
  const TelaCaptura({ Key? key }) : super(key: key);

  @override
  _TelaCapturaState createState() => _TelaCapturaState();
}

class _TelaCapturaState extends State<TelaCaptura> {

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  static const IconData pokeIcon = IconData(0xef36, fontFamily: 'MaterialIcons');
  List<int> numerosSorteados = [];
  
  List<Map<String, dynamic>> pokemonDataList = [];

  void initState() {
    super.initState();
    initConnectivity();
    

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

  }

  
  
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();

    } on PlatformException catch (e) {
      developer.log('deu bode no InitConnectivity', error: e);
      return;
    }


    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
    }



   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });

    if (_connectionStatus == ConnectivityResult.none) {
      print("Não há conexão");
      internetIndispToast();

    } else {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        print('conexao deu certo');

        // var numeros = sortearNumeros();

        // print(numeros);
        // obterDadosPokemons(numeros);

        
      
      });
      }
    }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarEdited(),
      body: FutureBuilder(
        future: obterDadosPokemons(sortearNumeros()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar os Pokémon'),
            );
          } else {
            return ListView.builder(
              itemCount: pokemonDataList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> pokemonData = pokemonDataList[index];
                return _buildPokemonCard(pokemonData);
              },
            );
          }
        },
      ),
    );
  }

  

    Widget _buildPokemonCard(Map<String, dynamic> pokemonData)  {
      String nomePokemon = pokemonData['name'];
      String imagemUrl = pokemonData['sprites']['front_default'];
      int pokeId = pokemonData['id'];
     
      //Pokemon pokemon = new Pokemon(pokemonData['id'], pokemonData['name'], pokemonData['type'], pokemonData['name'], hp, force, def, pokemonData['base_experience'])
      
      return Card(
        color: const Color.fromRGBO(165, 214, 167, 1),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Image.network(imagemUrl, height: 100, width: 100),
              const SizedBox(height: 15),
              Text(

                nomePokemon,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              
              ElevatedButton(
                onPressed: () { 
                 
                    capturaPokemon(pokemonData);
                  
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  
                  
                  
                ),
                
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.catching_pokemon,
                      // Você pode usar um ícone de Pokébola ou outro ícone relevante
                      size: 24,
                      color: Color.fromRGBO(165, 214, 167, 1),
                    ),
                    
                    
                  ],
                ),
              ),
            ],
          ),
        ),
  );
}


    void internetIndispToast(){
      Fluttertoast.showToast(msg: 'Internet Indispinível Jogador',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
      
      );
    }

    List<int> sortearNumeros() {
    Random random = Random();
    List<int> numerosSorteados = [];

    for (int i = 0; i < 6; i++) {
      int numeroSorteado = random.nextInt(1018); 
      numerosSorteados.add(numeroSorteado);
    }
    

      return numerosSorteados;
    }

    // Future procuraIdBanco() async {
    //   final database = await $FloorAppDatabase.databaseBuilder('app_database').build();
    //   final pokemonDao = database.pokemonDao;

    //   Pokemon pokemon = pokemonDao.findPokemonById()

    // }
    

    void capturaPokemon(pokemonData) async {
      final database = await $FloorAppDatabase.databaseBuilder('app_database').build();
      final pokemonDao = database.pokemonDao;

      String name = pokemonData['name'];
      int id = pokemonData['id'];
      var pokeStat = pokemonData['stats'];
      int hp = pokeStat[0]['base_stat'];
      String type = pokemonData['types'][0]['type']['name'];
      String evolve = pokemonData['name'];
      int force = pokeStat[1]['base_stat'];
      int def = pokeStat[2]['base_stat'];
      int xp = pokemonData['base_experience'];
      
      
      Pokemon pokemon = Pokemon(id, name, type, evolve, hp,force, def , xp);

      final pokes = pokemonDao.findAllPokemon();
      
      
      pokemonDao.insertPokemon(pokemon);
      

      //   Fluttertoast.showToast(msg: "GOTCHA !!!",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 5,
      //   backgroundColor: Colors.grey,
      //   textColor: Colors.white,
      //   fontSize: 16.0,);

      //   print("pokemon salvo no banco00");

      // }else{
      //   Fluttertoast.showToast(msg: "Pokemon já no banco",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 5,
      //   backgroundColor: Colors.grey,
      //   textColor: Colors.white,
      //   fontSize: 16.0,);
      // }
      

    }

   

  
    Future<void> obterDadosPokemons(List<int> numeros) async {
    pokemonDataList.clear();

      for (int numeroSorteado in numeros) {
        final response = await http.get(
          Uri.parse('https://pokeapi.co/api/v2/pokemon/$numeroSorteado/'),
        );
        

        if (response.statusCode == 200) {
          Map<String, dynamic> pokemonData = json.decode(response.body);

          String nomePokemon = pokemonData['name'];
          
          if (pokemonDataList.length < 6) { pokemonDataList.add(pokemonData); }
          
        } else {
          developer.log(
            'Deu erro ao pegar o Pokémon $numeroSorteado',
            error: response.statusCode.toString(),
          );
        }
      }

      
    }

    
 


} 