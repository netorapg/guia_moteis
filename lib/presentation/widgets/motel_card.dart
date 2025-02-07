import 'package:flutter/material.dart';
import '../../data/models/motel_model.dart';
import '../screens/motel_details_screen.dart';

class MotelCard extends StatelessWidget {
  final MotelModel motel;

  const MotelCard({super.key, required this.motel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          // Navegar para a tela de detalhes do motel
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MotelDetailsScreen(motel: motel),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(motel.logo, height: 150, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(motel.fantasia, style: Theme.of(context).textTheme.titleLarge),
                  Text(motel.bairro, style: TextStyle(color: Colors.grey)),
                  Text('Distância: ${motel.distancia} km', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
