import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:guia_moteis/data/services/motel_service.dart';
import 'package:guia_moteis/data/models/motel_model.dart';
import 'mocks.mocks.dart';

void main() {
  group('MotelService', () {
    late MotelService motelService;
    late MockClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockClient();
      motelService = MotelService(client: mockHttpClient);
    });

    test('should return a list of motels when the response is successful',
        () async {
      final mockResponse = utf8.encode(json.encode({
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
              "distancia": 28.27,
              "qtdFavoritos": 0,
              "suites": [],
              "qtdAvaliacoes": 2159,
              "media": 4.6,
              "mensagem": []
            }
          ]
        }
      }));

      when(mockHttpClient.get(Uri.parse(MotelService.apiUrl))).thenAnswer(
        (_) async =>
            http.Response.bytes(mockResponse, 200,
                headers: {"Content-Type": "application/json; charset=utf-8"}),
      );

      final result = await motelService.fetchMotels();

      expect(result, isA<List<MotelModel>>());
      expect(result.length, 1);
      expect(result[0].fantasia, 'Motel Le Nid');
    });

    test('should throw an exception when the response is an error', () async {
      when(mockHttpClient.get(Uri.parse(MotelService.apiUrl))).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      expect(() => motelService.fetchMotels(), throwsException);
    });

    test('should throw exception when response has invalid structure',
        () async {
      final mockResponse = json.encode({
        "sucesso": true,
        "data": {"moteis": "não sou uma lista"}
      });

      when(mockHttpClient.get(Uri.parse(MotelService.apiUrl))).thenAnswer(
        (_) async => http.Response.bytes(utf8.encode(mockResponse), 200,
            headers: {"Content-Type": "application/json; charset=utf-8"}),
      );

      expect(
        () async => await motelService.fetchMotels(),
        throwsA(
          isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains(
                  "A chave 'moteis' está presente, mas não contém uma lista válida")),
        ),
      );
    });
  });
}
