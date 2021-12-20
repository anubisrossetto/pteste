import 'package:pteste/models/tarefa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:pteste/database/app.database.dart';

class TarefasDao{

  static const String tableSQl = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_descricao TEXT, '
      '$_obs TEXT)';
  static const String _tableName = 'tarefas';
  static const String _id = 'id';
  static const String _descricao = 'descricao';
  static const String _obs = 'obs';


  Map<String, dynamic> toMap(Tarefa tarefa) {
    final Map<String, dynamic> tarefaMap = Map();
    tarefaMap[_descricao] = tarefa.descricao;
    tarefaMap[_obs] = tarefa.obs;
    return tarefaMap;
  }

  Future<int> save(Tarefa tarefa) async{
    final Database db = await getDatabase();
    Map<String, dynamic> tarefaMap = toMap(tarefa);
    return db.insert(_tableName, tarefaMap);
  }

  Future<int> update(Tarefa tarefa) async{
    final Database db = await getDatabase();
    Map<String, dynamic> tarefaMap = toMap(tarefa);
    debugPrint("dao alterar: " + tarefaMap.toString());
    debugPrint("dao id: " + tarefa.id.toString());
    return db.update(_tableName, tarefaMap, where: '$_id = ?', whereArgs: [tarefa.id]);
  }

  Future<int> delete(int id) async{
    final Database db = await getDatabase();
    debugPrint("excluindo");
    return db.delete(_tableName, where: '$_id = ?', whereArgs: [id]);
  }



  Future<List<Tarefa>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Tarefa> tarefas = toList(result);
    print("aqui");
    print(tarefas.toString());
    return tarefas;
  }

  List<Tarefa> toList(List<Map<String, dynamic>> result) {
    final List<Tarefa> tarefas = [];
    for (Map<String, dynamic> row in result) {
      final Tarefa tarefa = Tarefa(
        row[_id],
        row[_descricao],
        row[_obs],
      );
      tarefas.add(tarefa);
    }
    return tarefas;
  }

}