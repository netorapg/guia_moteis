import 'suite_model.dart';

class MotelModel {
  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;
  final List<Suite> suites;

  MotelModel({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.suites,
  });

  factory MotelModel.fromJson(Map<String, dynamic> json) {
  final suitesData = json["suites"] as List? ?? [];
    return MotelModel(
      fantasia: json["fantasia"] ?? "",
      logo: json["logo"] ?? "",
      bairro: json["bairro"] ?? "",
      distancia: (json["distancia"] ?? 0).toDouble(),
      suites: suitesData.map((suiteJson) => Suite.fromJson(suiteJson)).toList(),
    );
  }

  static List<MotelModel> fromJsonList(List<dynamic> list) {
    return list.map((item) => MotelModel.fromJson(item)).toList();
  }
}