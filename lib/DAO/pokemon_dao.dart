import 'package:floor/floor.dart';
import 'package:terceira_prova/domain/Pokemon.dart';


@dao
abstract class PokemonDAO{

  @Query('SELECT * FROM Pokemon')
  Future<List<Pokemon>> findAllPokemon();

  @Query('SELECT name FROM Pokemon')
  Stream<List<String>> findAll();

  @Query('SELECT * FROM Pokemon WHERE id = :id')
  Stream<Pokemon?> findPokemonById(int id);

  @insert
  Future<void> insertPokemon(Pokemon pokemon);

  @delete
  Future<void> deletePokemon(Pokemon pokemon);
}