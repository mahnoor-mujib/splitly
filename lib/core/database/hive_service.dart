import 'package:hive_flutter/hive_flutter.dart';

import '../../feautures/pocket/data/models/pocket_model.dart';

class HiveService {
  static const String pocketsBoxName = 'pockets_box';
  static const String transactionsBoxName = 'transactions_box';
  static const String goalsBoxName = 'goals_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    await Future.wait([
      Hive.openBox<PocketModel>(pocketsBoxName),
      Hive.openBox<dynamic>(transactionsBoxName),
      Hive.openBox<dynamic>(goalsBoxName),
    ]);
  }
}
