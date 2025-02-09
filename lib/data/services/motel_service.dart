import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/motel_model.dart';

class MotelService {
  static const String apiUrl = "https://www.jsonkeeper.com/b/1IXK";
  final http.Client client;

  MotelService({http.Client? client}) : client = client ?? http.Client();

  Future<List<MotelModel>> fetchMotels() async {
    try {
      final response = await client.get(Uri.parse(apiUrl));

      print('Resposta da API: ${response.body}');

      if (response.statusCode == 200) {
        final utf8Body = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> data = jsonDecode(utf8Body);

        print('Dados decodificados: $data');

        if (data.containsKey("data") && data["data"] is Map<String, dynamic>) {
          final dynamic motelsData = data["data"]["moteis"];

          if (motelsData is List) {
            return MotelModel.fromJsonList(motelsData);
          } else {
            throw Exception(
                "A chave 'moteis' está presente, mas não contém uma lista válida.");
          }
        } else {
          throw Exception(
              "Formato de resposta inválido: chave 'moteis' não encontrada");
        }
      } else {
        throw Exception(
            "Erro ao buscar motéis. Código: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Erro ao buscar motéis: $e");
    }
  }
}
