import '../models/motel_model.dart';
import '../services/motel_service.dart';

class MotelRepository {
  final MotelService service;

  MotelRepository(this.service);

  Future<List<MotelModel>> getMotels() async {
    return await service.fetchMotels();
  }
}
