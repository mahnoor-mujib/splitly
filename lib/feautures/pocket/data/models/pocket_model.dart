import 'package:hive/hive.dart';

part 'pocket_model.g.dart';

@HiveType(typeId: 0)
class PocketModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String iconEmoji;

  @HiveField(3)
  double balance;

  @HiveField(4)
  double targetAmount;

  @HiveField(5)
  double allocationPercentage;

  PocketModel({
    required this.id,
    required this.name,
    required this.iconEmoji,
    required this.balance,
    this.targetAmount = 0.0,
    this.allocationPercentage = 0.0,
  });

  PocketModel copyWith({
    String? name,
    String? iconEmoji,
    double? balance,
    double? targetAmount,
    double? allocationPercentage,
  }) {
    return PocketModel(
      id: id,
      name: name ?? this.name,
      iconEmoji: iconEmoji ?? this.iconEmoji,
      balance: balance ?? this.balance,
      targetAmount: targetAmount ?? this.targetAmount,
      allocationPercentage: allocationPercentage ?? this.allocationPercentage,
    );
  }
}
