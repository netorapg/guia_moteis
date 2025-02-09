import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../data/models/motel_model.dart';
import '../screens/suites_screen.dart';

class MotelCard extends StatelessWidget {
  final MotelModel motel;

  const MotelCard({super.key, required this.motel});

  @override
  Widget build(BuildContext context) {
    double? minPrice;
    double? maxPrice;

    if (motel.suites.isNotEmpty) {
      List<double> prices = [];

      for (var suite in motel.suites) {
        if (suite.periodos != null && suite.periodos.isNotEmpty) {
          for (var periodo in suite.periodos) {
            if (periodo.valor != null) {
              prices.add(periodo.valor!);
            }
          }
        }
      }

      if (prices.isNotEmpty) {
        minPrice = prices.reduce((a, b) => a < b ? a : b);
        maxPrice = prices.reduce((a, b) => a > b ? a : b);
      }
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MotelDetailsScreen(motel: motel),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  motel.logo,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      motel.fantasia,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 1),
                    Row(
                      children: [
                        const Icon(LucideIcons.star,
                            size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${motel.avaliacoes} Avaliações',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(LucideIcons.mapPin,
                            size: 16, color: Color.fromARGB(255, 221, 7, 7)),
                        const SizedBox(width: 4),
                        Text(
                          motel.bairro,
                          style: const TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(LucideIcons.navigation,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${motel.distancia} km',
                          style: const TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(LucideIcons.wallet,
                            size: 16, color: Colors.green),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            minPrice != null && maxPrice != null
                                ? 'Suítes entre R\$${minPrice.toStringAsFixed(2)} e R\$${maxPrice.toStringAsFixed(2)}'
                                : 'Valores não informados',
                            style: TextStyle(
                              color:
                                  minPrice != null ? Colors.black : Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios_rounded,
                    size: 20, color: Colors.redAccent),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MotelDetailsScreen(motel: motel),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
