import 'package:flutter/material.dart';
import '../../data/models/motel_model.dart';

class MotelCard extends StatelessWidget {
  final MotelModel motel;

  const MotelCard({super.key, required this.motel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(motel.imagemUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(motel.nome, style: Theme.of(context).textTheme.titleLarge),
                Text('R\$ ${motel.preco.toStringAsFixed(2)}', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
