import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 1)
enum TransactionType {
  @HiveField(0)
  expense,
  @HiveField(1)
  income,
  @HiveField(2)
  transfer,
}

@HiveType(typeId: 2)
class TransactionModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String pocketId;

  @HiveField(2)
  final String pocketName;

  @HiveField(3)
  final double amount;

  @HiveField(4)
  final TransactionType type;

  @HiveField(5)
  final String category;

  @HiveField(6)
  final DateTime timestamp;

  @HiveField(7)
  final String? note;

  TransactionModel({
    required this.id,
    required this.pocketId,
    required this.pocketName,
    required this.amount,
    required this.type,
    required this.category,
    required this.timestamp,
    this.note,
  });
}
