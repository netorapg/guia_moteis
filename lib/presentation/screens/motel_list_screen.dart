import 'package:flutter/material.dart';
import '../../data/models/motel_model.dart';
import '../../data/services/motel_service.dart';
import '../widgets/motel_card.dart';

class MotelListScreen extends StatefulWidget {
  @override
  _MotelListScreenState createState() => _MotelListScreenState();
}

class _MotelListScreenState extends State<MotelListScreen> {
  List<MotelModel> _motels = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true; // Verifica se há mais motéis para carregar

  // Função para carregar motéis
  Future<void> _loadMotels() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Certifique-se de que 'fetchMotels' está retornando uma lista válida
      final motels = await MotelService().fetchMotels(page: _currentPage);
      setState(() {
        _isLoading = false;
        _motels.addAll(motels);

        if (motels.isEmpty) {
          _hasMore = false; // Não há mais motéis para carregar
        } else {
          _currentPage++; // Aumenta a página para carregar os próximos resultados
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Exibir erro
      print("Erro ao carregar motéis: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMotels(); // Carregar motéis ao iniciar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Motéis')),
      body: ListView.builder(
        itemCount: _motels.length + 1, // Adiciona 1 item extra para o carregamento
        itemBuilder: (context, index) {
          if (index == _motels.length) {
            // Exibir indicador de carregamento se não houver mais motéis
            if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(); // Caso não haja mais motéis para carregar
            }
          }

          final motel = _motels[index];
          return MotelCard(motel: motel);
        },
        // Detectar quando o usuário chegou ao final da lista
        controller: ScrollController()..addListener(() {
          if (_isLoading || !_hasMore) return;

          final scrollPosition = ScrollController().position;
          if (scrollPosition.pixels == scrollPosition.maxScrollExtent) {
            // Quando chegar ao final, carrega mais motéis
            _loadMotels();
          }
        }),
      ),
    );
  }
}