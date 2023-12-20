import 'package:flutter/material.dart';
import 'package:terceira_prova/domain/Pokemon.dart';
// import 'package:terceira_prova/repository/app_database.dart';
// import 'package:terceira_prova/widgets/tela_captura.dart';
import 'package:terceira_prova/widgets/tela_home.dart';

void main(){
  runApp(const MyApp());
  
  
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const TelaHome();
  }
}

