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
          // Exibe o logo do motel
          Image.network(motel.logo, height: 150, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome fantasia do motel
                Text(
                  motel.fantasia,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // Bairro onde o motel está localizado
                Text(
                  motel.bairro,
                  style: TextStyle(color: Colors.grey),
                ),
                // Distância do motel
                Text(
                  'Distância: ${motel.distancia.toStringAsFixed(2)} km',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
