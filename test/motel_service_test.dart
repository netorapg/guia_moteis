import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:guia_moteis/data/services/motel_service.dart';
import 'package:guia_moteis/data/models/motel_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Mock HttpClient
class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('MotelService', () {
    late MotelService motelService;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      motelService = MotelService(client: mockHttpClient); // Passando o mock
    });

    test('should return a list of motels when the response is successful', () async {
      // Simulando a resposta da API
      final mockResponse = json.encode({
        "sucesso": true,
        "data": {
          "pagina": 1,
          "qtdPorPagina": 10,
          "totalSuites": 0,
          "totalMoteis": 1,
          "raio": 0,
          "maxPaginas": 1.0,
          "moteis": [
            {
              "fantasia": "Motel Le Nid",
              "logo": "https://example.com/logo.gif",
              "bairro": "Chácara Flora - São Paulo",
              "distancia": 28.27
            }
          ]
        }
      });

      // Configurando o mock para retornar a resposta simulada
      when(mockHttpClient.get(Uri.parse(MotelService.apiUrl)))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      // Testando o método
      final result = await motelService.fetchMotels();

      // Verificando se o resultado é uma lista de motéis
      expect(result, isA<List<MotelModel>>());
      expect(result.length, 1);
      expect(result[0].fantasia, 'Motel Le Nid');
    });

    test('should throw an exception when the response is an error', () async {
      // Simulando uma resposta de erro da API
      when(mockHttpClient.get(Uri.parse(MotelService.apiUrl)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Verificando se a exceção é lançada corretamente
      expect(() => motelService.fetchMotels(), throwsException);
    });
  });
}
