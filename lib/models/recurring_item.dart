enum RecurringType {
  income,
  expense,
}

enum RecurringFrequency {
  daily,
  weekly,
  monthly,
}

extension RecurringFrequencyExtension on RecurringFrequency {
  String get label {
    switch (this) {
      case RecurringFrequency.daily:
        return 'Daily';
      case RecurringFrequency.weekly:
        return 'Weekly';
      case RecurringFrequency.monthly:
        return 'Monthly';
    }
  }

  int get days {
    switch (this) {
      case RecurringFrequency.daily:
        return 1;
      case RecurringFrequency.weekly:
        return 7;
      case RecurringFrequency.monthly:
        return 30;
    }
  }
}

class RecurringItem {
  final String id;
  final String name;
  final double amount;
  final RecurringType type;
  final RecurringFrequency frequency;
  final String? pocketId;
  final int dayOfMonth;
  final bool followsSplitPlan;
  final bool isActive;

  const RecurringItem({
    required this.id,
    required this.name,
    required this.amount,
    required this.type,
    required this.frequency,
    this.pocketId,
    this.dayOfMonth = 1,
    this.followsSplitPlan = false,
    this.isActive = true,
  });

  RecurringItem copyWith({
    String? id,
    String? name,
    double? amount,
    RecurringType? type,
    RecurringFrequency? frequency,
    String? pocketId,
    int? dayOfMonth,
    bool? followsSplitPlan,
    bool? isActive,
  }) {
    return RecurringItem(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      frequency: frequency ?? this.frequency,
      pocketId: pocketId ?? this.pocketId,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
      followsSplitPlan: followsSplitPlan ?? this.followsSplitPlan,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'type': type.index,
      'frequency': frequency.index,
      'pocketId': pocketId,
      'dayOfMonth': dayOfMonth,
      'followsSplitPlan': followsSplitPlan ? 1 : 0,
      'isActive': isActive ? 1 : 0,
    };
  }

  factory RecurringItem.fromMap(Map<String, dynamic> map) {
    return RecurringItem(
      id: map['id'] as String,
      name: map['name'] as String,
      amount: (map['amount'] as num).toDouble(),
      type: RecurringType.values[map['type'] as int],
      frequency: RecurringFrequency.values[map['frequency'] as int],
      pocketId: map['pocketId'] as String?,
      dayOfMonth: map['dayOfMonth'] as int,
      followsSplitPlan: (map['followsSplitPlan'] as int) == 1,
      isActive: (map['isActive'] as int) == 1,
    );
  }
}