import 'package:flutter/foundation.dart';

class HiveService {
  static const String pocketsBoxName = 'pockets_box';
  static const String transactionsBoxName = 'transactions_box';
  static const String goalsBoxName = 'goals_box';

  static Future<void> init() async {
    debugPrint(
      'HiveService.init() is a placeholder. The app currently persists data via SharedPreferences.',
    );
  }
}
