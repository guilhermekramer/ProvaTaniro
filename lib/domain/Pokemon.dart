
import 'package:floor/floor.dart';

@Entity(tableName: 'Pokemon')
class Pokemon{

  @primaryKey
  int id = 0;
  String name = '';
  String type = '';
  String evolve = '';
  int hp = 0;
  int force = 0;
  int def = 0;
  int xp = 0;

  Pokemon(this.id,this.name, this.type, this.evolve, this.hp, this.force, this.def, this.xp);

  List<String> toList() {
    return [id.toString(), name, type, evolve, hp.toString(), force.toString(), def.toString(), xp.toString()];
  }

  factory Pokemon.fromList(List<String> list) {
    int id = int.tryParse(list[0]) ?? 0;
    String name = list[1];
    String type = list[2];
    String evolve = list[3];
    int hp = int.tryParse(list[4]) ?? 0;
    int force = int.tryParse(list[5]) ?? 0;
    int def = int.tryParse(list[6]) ?? 0;
    int xp = int.tryParse(list[7]) ?? 0;

    return Pokemon(id, name, type, evolve, hp, force, def, xp);
  }

}