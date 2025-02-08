import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../data/models/suite_model.dart';

class SuiteCard extends StatelessWidget {
  final Suite suite;

  const SuiteCard({super.key, required this.suite});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Elevação para dar destaque
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Bordas arredondadas
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          _showPeriodosDialog(context, suite);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                suite.fotos.isNotEmpty ? suite.fotos[0] : '',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors
                      .grey[300], // Mostra um fundo cinza se a imagem falhar
                  child: const Icon(Icons.broken_image,
                      size: 50, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suite.nome,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'A partir de R\$ ${suite.periodos.isNotEmpty ? suite.periodos.first.valor.toStringAsFixed(2) : '--'}',
                    style: const TextStyle(
                    //  color: Color(0xFF480679),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 void _showPeriodosDialog(BuildContext context, Suite suite) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Título estilizado
              Text(
                'Períodos de ${suite.nome}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Tabela de períodos
              if (suite.periodos.isNotEmpty)
                DataTable(
                  columnSpacing: 20, // Espaçamento entre as colunas
                  columns: [
                    DataColumn(
                      label: Row(
                        children: const [
                          Icon(LucideIcons.clock, size: 18, color: Colors.blue), // Ícone de relógio
                          SizedBox(width: 8), // Espaçamento entre ícone e texto
                          Text(
                            'Tempo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataColumn(
                      label: Row(
                        children: const [
                          Icon(LucideIcons.wallet, size: 18, color: Colors.green), // Ícone de carteira
                          SizedBox(width: 8), // Espaçamento entre ícone e texto
                          Text(
                            'Valor',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  rows: suite.periodos.map((periodo) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            periodo.tempoFormatado,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataCell(
                          Text(
                            'R\$ ${periodo.valor.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              // color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                )
              else
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Nenhum período disponível.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),

              const SizedBox(height: 8),

              // Botão de fechar centralizado
              Center( // Substitui Align por Center
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Fechar',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
}
