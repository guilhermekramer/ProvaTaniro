import 'package:floor/floor.dart';
import 'package:terceira_prova/DAO/pokemon_dao.dart';
import 'package:terceira_prova/domain/Pokemon.dart';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';


part 'app_database.g.dart';


@Database(version: 1, entities: [Pokemon])
abstract class AppDatabase extends FloorDatabase{

  PokemonDAO get pokemonDao;
  
}