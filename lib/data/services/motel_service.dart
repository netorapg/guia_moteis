import 'dart:convert';
import '../../core/http_client.dart';
import '../models/motel_model.dart';

class MotelService {
  static const String apiUrl = "https://www.jsonkeeper.com/b/1IXK";

  Future<List<MotelModel>> fetchMotels() async {
    try {
      final response = await HttpClient.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

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
