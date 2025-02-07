import 'dart:convert';
import '../../core/http_client.dart'; // O seu HttpClient customizado
import '../models/motel_model.dart';

class MotelService {
  static const String apiUrl = "https://www.jsonkeeper.com/b/1IXK";

  Future<List<MotelModel>> fetchMotels() async {
    try {
      final response = await HttpClient.get(apiUrl); // Usando o HttpClient customizado

      if (response.statusCode == 200) {
        // Garantir que a resposta seja tratada corretamente em UTF-8
        final utf8Body = utf8.decode(response.bodyBytes);

        // Decodifica o JSON após a conversão para UTF-8
        final Map<String, dynamic> data = jsonDecode(utf8Body);

        // Acessamos "data" -> "moteis"
        if (data.containsKey("data") && data["data"].containsKey("moteis")) {
          final List<dynamic> motelsJson = data["data"]["moteis"];
          return MotelModel.fromJsonList(motelsJson);
        } else {
          throw Exception("Formato de resposta inválido: chave 'moteis' não encontrada");
        }
      } else {
        throw Exception("Erro ao buscar motéis. Código: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Erro ao buscar motéis: $e");
    }
  }
}
