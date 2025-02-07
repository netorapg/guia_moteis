import 'package:flutter/material.dart';
import '../../data/models/motel_model.dart';

class MotelDetailsScreen extends StatelessWidget {
  final MotelModel motel;

  const MotelDetailsScreen({super.key, required this.motel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(motel.fantasia),
      ),
      body: motel.suites.isEmpty
          ? const Center(child: Text('Nenhuma suíte disponível'))
          : ListView.builder(
              itemCount: motel.suites.length,
              itemBuilder: (context, index) {
                final suite = motel.suites[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        suite.fotos[0],
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
                            Text('R\$ ${suite.valorTotal.toStringAsFixed(2)}', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
