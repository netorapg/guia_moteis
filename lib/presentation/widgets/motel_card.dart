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
          Image.network(
            motel.logo,  // Usando o logo como imagem do motel
            height: 150, 
            width: double.infinity, 
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  motel.fantasia,  // Usando o nome fantasia como o nome do motel
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Distância: ${motel.distancia.toStringAsFixed(2)} km',  // Mostrando a distância
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  'Bairro: ${motel.bairro}',  // Exibindo o bairro
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
