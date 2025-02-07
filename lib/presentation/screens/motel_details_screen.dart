import 'package:flutter/material.dart';
import '../../data/models/motel_model.dart';
import '../widgets/suite_card.dart'; // Importando o card da suíte

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
                return SuiteCard(suite: suite);
              },
            ),
    );
  }
}
