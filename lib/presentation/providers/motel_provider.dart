import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_motels.dart';
import '../../data/models/motel_model.dart';
import '../../data/repositories/motel_repository.dart';
import '../../data/services/motel_service.dart';

final motelProvider = FutureProvider<List<MotelModel>>((ref) async {
  final repository = MotelRepository(MotelService());
  final usecase = GetMotels(repository);
  return await usecase();
});