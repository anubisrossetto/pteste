import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pteste/database/tarefas_dao.dart';

  Future<Database> getDatabase() async {
    final String path = join(await getDatabasesPath(), 'dbtarefas.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(TarefasDao.tableSQl);
      },
      version: 1,
    );
  }
