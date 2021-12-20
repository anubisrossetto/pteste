import 'package:flutter/material.dart';
import 'package:pteste/components/Editor.dart';
import 'package:pteste/models/tarefa.dart';

class FormTarefa extends StatelessWidget {

  final TextEditingController _controladorTarefa = TextEditingController();
  final TextEditingController _controladorObs = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Formulário Tarefas')),
      body: SingleChildScrollView(
        child:
        Column(
          children: [
            Editor(_controladorTarefa,
                "Tarefa",
                "Informe Tarefa",
                Icons.assignment),
            Editor(_controladorObs,
                "Obs",
                "Informe Obs",
                Icons.assignment),
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
  }

  void _criarTarefa(BuildContext context) {
    print("clicou no confirmar");
    final tarefaCriada = Tarefa(_controladorTarefa.text, _controladorObs.text);
    debugPrint('Tarefa criada: $tarefaCriada');
    Navigator.pop(context,tarefaCriada);
    final SnackBar snackBar = SnackBar(content: const Text('Tarefa criada!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
