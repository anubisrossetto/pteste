import 'package:flutter/material.dart';
import 'package:pteste/models/tarefa.dart';
import 'package:pteste/screens/form.dart';
import 'package:pteste/database/tarefas_dao.dart';

class ListaTarefa extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListaTarefaState();
    //  throw UnimplementedError();
  }
}

class ListaTarefaState extends State<ListaTarefa> {
  final TarefasDao _dao = new TarefasDao();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Tarefas"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              final Future future =
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormTarefa();
              }));
              future.then((tarefa) {
                debugPrint("retornou do form");
                setState(() {});
              });
            },
            child: Icon(Icons.add)),
        body: FutureBuilder<List<Tarefa>>(
            initialData: [],
            future: Future.delayed(Duration(seconds: 1))
                .then((value) => _dao.findAll()),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  if (snapshot.data != null) {
                    final List<Tarefa>? tarefas = snapshot.data;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Tarefa tarefa = tarefas![index];
                        return ItemTarefa(context, tarefa);
                      },
                      itemCount: tarefas!.length,
                    );
                  }
                  break;
                default:
                  return Center(child: Text("nenhuma tarefa "));
              } //switch
              return Center(child: Text("carregando tarefa "));
            } //builder
            ));
    //  throw UnimplementedError();
  }

  Widget ItemTarefa(BuildContext context, Tarefa _tarefa) {
    /*   return Card(
        child: ListTile(
      leading: Icon(Icons.add_alert),
      title: Text(_tarefa.descricao),
      subtitle: Text(_tarefa.obs),
      enabled: true,
      onTap: () {
        final Future future =
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FormTarefa(tarefa: _tarefa);
        }));
        future.then((tarefa) {
          setState(() {});
        });
      },
    ));
  */

    return GestureDetector(
      onTap: () {
        final Future future =
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FormTarefa(tarefa: _tarefa);
        }));
        future.then((tarefa) {
          setState(() {});
        });
      },
      child: Card(
        child: ListTile(
          title: Text(_tarefa.descricao),
          subtitle: Text(_tarefa.obs),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _excluir(context, _tarefa.id);
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _excluir(BuildContext ctx, int id) {
    print('cliclou no excluir');
    _dao.delete(id).then((id) => setState(() {}));
  }
}
