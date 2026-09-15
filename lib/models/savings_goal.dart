class SavingsGoal {
  final String id;
  final String name;
  final String emoji;
  final double target;
  final double currentAmount;
  final DateTime? deadline;
  final bool isPinned;

  const SavingsGoal({
    required this.id,
    required this.name,
    required this.emoji,
    required this.target,
    this.currentAmount = 0,
    this.deadline,
    this.isPinned = false,
  });

  SavingsGoal copyWith({
    String? id,
    String? name,
    String? emoji,
    double? target,
    double? currentAmount,
    DateTime? deadline,
    bool? isPinned,
  }) {
    return SavingsGoal(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      target: target ?? this.target,
      currentAmount: currentAmount ?? this.currentAmount,
      deadline: deadline ?? this.deadline,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  double get progress {
    if (target == 0) return 0;
    return (currentAmount / target).clamp(0.0, 1.0);
  }

  double get remaining => (target - currentAmount).clamp(0.0, double.infinity);

  double get requiredMonthlySaving {
    if (deadline == null) return 0;
    final months = deadline!
        .difference(DateTime.now())
        .inDays /
        30.0;
    if (months <= 0) return remaining;
    return remaining / months;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'emoji': emoji,
      'target': target,
      'currentAmount': currentAmount,
      'deadline': deadline?.millisecondsSinceEpoch,
      'isPinned': isPinned ? 1 : 0,
    };
  }

  factory SavingsGoal.fromMap(Map<String, dynamic> map) {
    return SavingsGoal(
      id: map['id'] as String,
      name: map['name'] as String,
      emoji: map['emoji'] as String,
      target: (map['target'] as num).toDouble(),
      currentAmount: (map['currentAmount'] as num).toDouble(),
      deadline: map['deadline'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int),
      isPinned: (map['isPinned'] as int) == 1,
    );
  }
}