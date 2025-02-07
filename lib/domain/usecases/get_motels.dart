import '../../data/repositories/motel_repository.dart';
import '../../data/models/motel_model.dart';

class GetMotels {
  final MotelRepository repository;

  GetMotels(this.repository);

  Future<List<MotelModel>> call() async {
    return await repository.getMotels();
  }
}
