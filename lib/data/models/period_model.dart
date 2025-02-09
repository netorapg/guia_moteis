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
