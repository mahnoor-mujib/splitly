import 'package:hive/hive.dart';

import '../../../../core/database/hive_service.dart';
import '../models/pocket_model.dart';

class PocketRepository {
  Box<PocketModel> get _box {
    if (!Hive.isBoxOpen(HiveService.pocketsBoxName)) {
      throw StateError('Pocket box is not initialized.');
    }

    return Hive.box<PocketModel>(HiveService.pocketsBoxName);
  }

  List<PocketModel> getPockets() => _box.values.toList();

  Future<void> addPocket(PocketModel pocket) async {
    await _box.put(pocket.id, pocket);
  }

  Future<void> updatePocket(PocketModel pocket) async {
    await _box.put(pocket.id, pocket);
  }

  Future<void> splitIncome(
    double totalIncome,
    Map<String, double> percentageMap,
  ) async {
    for (var entry in percentageMap.entries) {
      final pocket = _box.get(entry.key);
      if (pocket != null) {
        final addedAmount = totalIncome * (entry.value / 100);
        pocket.balance += addedAmount;
        await _box.put(pocket.id, pocket);
      }
    }
  }

  Future<void> transferMoney(
    String fromPocketId,
    String toPocketId,
    double amount,
  ) async {
    final fromPocket = _box.get(fromPocketId);
    final toPocket = _box.get(toPocketId);

    if (fromPocket != null &&
        toPocket != null &&
        fromPocket.balance >= amount) {
      fromPocket.balance -= amount;
      toPocket.balance += amount;
      await _box.put(fromPocket.id, fromPocket);
      await _box.put(toPocket.id, toPocket);
    }
  }
}
