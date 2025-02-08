import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

// Gera um mock para `http.Client`
@GenerateMocks([http.Client])
void main() {} // Obrigatório, mas não será usado
