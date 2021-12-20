import 'package:flutter/material.dart';
import 'package:pteste/models/tarefa.dart';
import 'package:pteste/screens/form.dart';

class ItemTarefa extends StatelessWidget {

  final Tarefa _tarefa;
  const ItemTarefa(this._tarefa);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Card(
        child : ListTile(
          leading : Icon(Icons.add_alert),
          title: Text(this._tarefa.descricao),
          subtitle: Text(this._tarefa.obs),
        )
    );
    //throw UnimplementedError();
  }
}

class ListaTarefa extends StatefulWidget{

  final List<Tarefa> _tarefas = [];

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListaTarefaState();
    //  throw UnimplementedError();
  }

}

class ListaTarefaState extends State<ListaTarefa>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
          appBar: AppBar(
            title: Text("Tarefas"),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                final Future future = Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return FormTarefa();
                    }));
                future.then((tarefa) {
                  debugPrint("retornou do form");
                  debugPrint('$tarefa');
                  setState(() {
                    widget._tarefas.add(tarefa);
                  });
                });
              },
              child: Icon(Icons.add)
          ),
          body: ListView.builder(
              itemCount: widget._tarefas.length,
              itemBuilder: (context, indice){
                final tarefa = widget._tarefas[indice];
                return ItemTarefa(tarefa);
              })
      );
    //  throw UnimplementedError();
  }

}

