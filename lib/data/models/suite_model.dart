class Suite {
  final String nome;
  final double valorTotal;
  final List<String> fotos;
  final List<Periodo> periodos;

  Suite({
    required this.nome,
    required this.valorTotal,
    required this.fotos,
    required this.periodos,
  });

  factory Suite.fromJson(Map<String, dynamic> json) {
    var periodosList = (json["periodos"] as List).map((periodoJson) => Periodo.fromJson(periodoJson)).toList();

    return Suite(
      nome: json["nome"] ?? "",
      valorTotal: (json["valorTotal"] ?? 0).toDouble(),
      fotos: List<String>.from(json["fotos"] ?? []),
      periodos: periodosList,
    );
  }
}

class Periodo {
  final String tempoFormatado;
  final double valor;

  Periodo({
    required this.tempoFormatado,
    required this.valor,
  });

  factory Periodo.fromJson(Map<String, dynamic> json) {
    return Periodo(
      tempoFormatado: json["tempoFormatado"] ?? "",
      valor: (json["valor"] ?? 0).toDouble(),
    );
  }
}
