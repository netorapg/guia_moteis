import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../../core/http_client.dart';
import '../models/motel_model.dart';

class MotelService {
  static const String apiUrl = "https://www.jsonkeeper.com/b/1IXK";

  Future<List<MotelModel>> fetchMotels({int page = 1}) async {
    try {
      // Inclui o parâmetro de página na URL
      final response = await HttpClient.get('$apiUrl?page=$page'); 

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Acessamos "data" -> "moteis"
        if (data.containsKey("data") && data["data"].containsKey("moteis")) {
          final List<dynamic> motelsJson = data["data"]["moteis"];
             if (kDebugMode) {
              print(data);
            }  // Imprime a resposta da API
          return MotelModel.fromJsonList(motelsJson);  // Retorna a lista de motéis
         
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
