import 'package:flutter/material.dart';
import '../../data/models/suite_model.dart';

class SuiteCard extends StatelessWidget {
  final Suite suite;

  const SuiteCard({super.key, required this.suite});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          // Exibe o dialog com os valores dos períodos
          _showPeriodosDialog(context, suite);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              suite.fotos.isNotEmpty ? suite.fotos[0] : '', // Verifica se há fotos
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(suite.nome, style: Theme.of(context).textTheme.titleLarge),
                //  Text('Valor Total: R\$ ${suite.valorTotal.toStringAsFixed(2)}', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função que exibe o diálogo com os valores dos períodos
  void _showPeriodosDialog(BuildContext context, Suite suite) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Períodos de ${suite.nome}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: suite.periodos.map((periodo) {
              return ListTile(
                title: Text(periodo.tempoFormatado),
                trailing: Text('R\$ ${periodo.valor.toStringAsFixed(2)}'),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
