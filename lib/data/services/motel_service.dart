import '../../core/http_client.dart';
import '../models/motel_model.dart';

class MotelService {
  static const String apiUrl = "https://jsonkeeper.com/b/1IXK";

  Future<List<MotelModel>> fetchMotels() async {
    final response = await HttpClient.get(apiUrl);
    if (response.statusCode == 200) {
      return MotelModel.fromJsonList(response.body);
    } else {
      throw Exception("Erro ao buscar motéis");
    }
  }
}
