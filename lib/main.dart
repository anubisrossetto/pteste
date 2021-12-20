import 'package:flutter/material.dart';
import 'package:pteste/screens/lista.dart';
import 'package:pteste/database/app.database.dart';
import 'package:pteste/models/tarefa.dart';

void main() {
  runApp(TarefaApp());
  /*TarefasDao tarefasDao = new TarefasDao();

  tarefasDao.save(Tarefa(0, 'tarefa 2', 'obs 2')).then((id){
       print("ID: " + id.toString());
       tarefasDao.findAll().then((tarefa) => debugPrint(tarefa.toString()));
    });

   */
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
