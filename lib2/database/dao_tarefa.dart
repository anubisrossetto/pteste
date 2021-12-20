import 'package:pteste/models/tarefa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class TarefasDao{

  Future<Database> getDatabase() async {
    final String path = join(await getDatabasesPath(), 'dbtarefas.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute('CREATE TABLE tarefas('
        ' id INTEGER PRIMARY KEY, '
        ' descricao TEXT, '
            ' obs TEXT)');
      },
      version: 1,
    );
  }

  Map<String, dynamic> toMap(Tarefa tarefa) {
    final Map<String, dynamic> tarefaMap = Map();
    tarefaMap['descricao'] = tarefa.descricao;
    tarefaMap['obs'] = tarefa.obs;
    return tarefaMap;
  }

  Future<int> save(Tarefa tarefa) async{
    final Database db = await getDatabase();
    Map<String, dynamic> tarefaMap = toMap(tarefa);
    return db.insert('tarefas', tarefaMap);
  }

  Future<int> update(Tarefa tarefa) async{
    final Database db = await getDatabase();
    Map<String, dynamic> tarefaMap = toMap(tarefa);
    debugPrint("dao alterar: " + tarefaMap.toString());
    debugPrint("dao id: " + tarefa.id.toString());
    return db.update('tarefas', tarefaMap, where: 'id = ?', whereArgs: [tarefa.id]);
  }

  Future<int> delete(int id) async{
    final Database db = await getDatabase();
    debugPrint("excluindo");
    return db.delete('tarefas', where: 'id = ?', whereArgs: [id]);
  }



  Future<List<Tarefa>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('tarefas');
    List<Tarefa> tarefas = toList(result);
    return tarefas;
  }

  List<Tarefa> toList(List<Map<String, dynamic>> result) {
    final List<Tarefa> tarefas = [];
    for (Map<String, dynamic> row in result) {
      final Tarefa tarefa = Tarefa(
        row['id'],
        row['descricao'],
        row['obs'],
      );
      tarefas.add(tarefa);
    }
    return tarefas;
  }

}