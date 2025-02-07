import 'dart:convert';

class MotelModel {
  final String nome;
  final double preco;
  final String imagemUrl;

  MotelModel({required this.nome, required this.preco, required this.imagemUrl});

  factory MotelModel.fromJson(Map<String, dynamic> json) {
    return MotelModel(
      nome: json['nome'],
      preco: (json['preco'] as num).toDouble(),
      imagemUrl: json['imagem'],
    );
  }

  static List<MotelModel> fromJsonList(String jsonStr) {
    final List<dynamic> jsonList = json.decode(jsonStr);
    return jsonList.map((json) => MotelModel.fromJson(json)).toList();
  }
}
