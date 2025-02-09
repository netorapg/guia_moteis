import 'package:http/http.dart' as http;

class HttpClient {
  static final http.Client _client = http.Client();

  static Future<http.Response> get(String url) async {
    return await _client.get(Uri.parse(url));
  }
}
