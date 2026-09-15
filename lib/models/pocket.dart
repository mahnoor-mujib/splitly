class Pocket {
  final String id;
  final String name;
  final String emoji;
  final double balance;
  final double? target;
  final DateTime? deadline;
  final bool isDefault;

  const Pocket({
    required this.id,
    required this.name,
    required this.emoji,
    this.balance = 0,
    this.target,
    this.deadline,
    this.isDefault = false,
  });

  Pocket copyWith({
    String? id,
    String? name,
    String? emoji,
    double? balance,
    double? target,
    DateTime? deadline,
    bool? isDefault,
  }) {
    return Pocket(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      balance: balance ?? this.balance,
      target: target ?? this.target,
      deadline: deadline ?? this.deadline,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  double get progress {
    if (target == null || target == 0) return 0;
    return (balance / target!).clamp(0.0, 1.0);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'emoji': emoji,
      'balance': balance,
      'target': target,
      'deadline': deadline?.millisecondsSinceEpoch,
      'isDefault': isDefault ? 1 : 0,
    };
  }

  factory Pocket.fromMap(Map<String, dynamic> map) {
    return Pocket(
      id: map['id'] as String,
      name: map['name'] as String,
      emoji: map['emoji'] as String,
      balance: (map['balance'] as num).toDouble(),
      target: (map['target'] as num?)?.toDouble(),
      deadline: map['deadline'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int),
      isDefault: (map['isDefault'] as int) == 1,
    );
  }
}