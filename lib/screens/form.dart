import 'package:flutter/material.dart';
import 'package:pteste/components/Editor.dart';
import 'package:pteste/models/tarefa.dart';
import 'package:pteste/database/tarefas_dao.dart';

class FormTarefa extends StatefulWidget {

  final Tarefa? tarefa;

  FormTarefa({this.tarefa});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FormTarefaState();
    throw UnimplementedError();
  }
}

class FormTarefaState extends State<FormTarefa> {
  final TextEditingController _controladorTarefa = TextEditingController();
  final TextEditingController _controladorObs = TextEditingController();
  int? _id;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Formulário Tarefas')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(_controladorTarefa, "Tarefa", "Informe Tarefa",
                Icons.assignment),
            Editor(_controladorObs, "Obs", "Informe Obs", Icons.add_alert),
            ElevatedButton(
              // style: styleFrom(TextStyle(fontSize: 20)),
              onPressed: () {
                _criarTarefa(context);
                // Ctrl + Alt + m --> para extrair código para método
              },
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  } // comentário


  void _criarTarefa(BuildContext ctx) {
    TarefasDao _dao = new TarefasDao();
    if (_id != null) {
      //alteração
      debugPrint("id: " + _id.toString());
      final tarefaCriada = Tarefa(
          _id!, _controladorTarefa.text, _controladorObs.text);
      debugPrint('$tarefaCriada');
      _dao.update(tarefaCriada).then((_id) => Navigator.pop(context));
    } else {
      // inclusão
      final tarefaCriada =
      Tarefa(0, _controladorTarefa.text, _controladorObs.text);
      _dao.save(tarefaCriada).then((id) => Navigator.pop(context));
    }

  }

  @override
  void initState() {
    super.initState();
    if (widget.tarefa != null) {
      _id = widget.tarefa!.id;
      _controladorTarefa.text = widget.tarefa!.descricao;
      _controladorObs.text = widget.tarefa!.obs;
    }
  }

}
