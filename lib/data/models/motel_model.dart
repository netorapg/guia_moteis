class MotelModel {
  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;

  MotelModel({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
  });

  factory MotelModel.fromJson(Map<String, dynamic> json) {
    return MotelModel(
      fantasia: json["fantasia"] ?? "",
      logo: json["logo"] ?? "",
      bairro: json["bairro"] ?? "",
      distancia: (json["distancia"] ?? 0).toDouble(),
    );
  }

  static List<MotelModel> fromJsonList(List<dynamic> list) {
    return list.map((item) => MotelModel.fromJson(item)).toList();
  }
}
