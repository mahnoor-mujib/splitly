class SplitRule {
  final String pocketId;
  final String emoji;
  final double percentage;
  final double? fixedAmount;

  const SplitRule({
    required this.pocketId,
    required this.emoji,
    required this.percentage,
    this.fixedAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'pocketId': pocketId,
      'emoji': emoji,
      'percentage': percentage,
      'fixedAmount': fixedAmount,
    };
  }

  factory SplitRule.fromMap(Map<String, dynamic> map) {
    return SplitRule(
      pocketId: map['pocketId'] as String,
      emoji: map['emoji'] as String,
      percentage: (map['percentage'] as num).toDouble(),
      fixedAmount: (map['fixedAmount'] as num?)?.toDouble(),
    );
  }
}

class SplitPlan {
  final String name;
  final List<SplitRule> rules;
  final bool isDefault;

  const SplitPlan({
    this.name = 'Default',
    this.rules = const [],
    this.isDefault = false,
  });

  double get totalPercentage =>
      rules.fold(0, (sum, r) => sum + r.percentage);

  double amountFor(double total, SplitRule rule) {
    if (rule.fixedAmount != null) return rule.fixedAmount!;
    return total * rule.percentage / 100;
  }

  bool get isValid => totalPercentage == 100 && rules.isNotEmpty;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isDefault': isDefault ? 1 : 0,
      'rules': rules.map((r) => r.toMap()).toList(),
    };
  }

  factory SplitPlan.fromMap(Map<String, dynamic> map) {
    return SplitPlan(
      name: map['name'] as String,
      isDefault: (map['isDefault'] as int) == 1,
      rules: (map['rules'] as List)
          .map((e) => SplitRule.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}