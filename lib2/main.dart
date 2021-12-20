import 'package:flutter/material.dart';
import 'package:pteste/screens/lista.dart';
import 'package:pteste/models/tarefa.dart';
import 'package:pteste/database/dao_tarefa.dart';

void main() {
  runApp(TarefaApp());
  TarefasDao teste = new TarefasDao();

  teste.save(Tarefa(0, 'teste', 'obs')).then((id){
    teste.findAll().then((tarefa) => debugPrint(tarefa.toString()));
    });
}

class TarefaApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {



    // TODO: implement build
    return MaterialApp(
        home: ListaTarefa()
    );
    //throw UnimplementedError();
  }

}
