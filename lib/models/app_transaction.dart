enum TransactionType {
  income,
  expense,
  transferIn,
  transferOut,
}

extension TransactionTypeExtension on TransactionType {
  String get label {
    switch (this) {
      case TransactionType.income:
        return 'Income';
      case TransactionType.expense:
        return 'Expense';
      case TransactionType.transferIn:
        return 'Transfer In';
      case TransactionType.transferOut:
        return 'Transfer Out';
    }
  }
}

class AppTransaction {
  final String id;
  final String pocketId;
  final String? toPocketId;
  final double amount;
  final String category;
  final String paymentMethod;
  final String? note;
  final TransactionType type;
  final DateTime date;

  const AppTransaction({
    required this.id,
    required this.pocketId,
    this.toPocketId,
    required this.amount,
    required this.category,
    required this.paymentMethod,
    this.note,
    required this.type,
    required this.date,
  });

  AppTransaction copyWith({
    String? id,
    String? pocketId,
    String? toPocketId,
    double? amount,
    String? category,
    String? paymentMethod,
    String? note,
    TransactionType? type,
    DateTime? date,
  }) {
    return AppTransaction(
      id: id ?? this.id,
      pocketId: pocketId ?? this.pocketId,
      toPocketId: toPocketId ?? this.toPocketId,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      note: note ?? this.note,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pocketId': pocketId,
      'toPocketId': toPocketId,
      'amount': amount,
      'category': category,
      'paymentMethod': paymentMethod,
      'note': note,
      'type': type.index,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory AppTransaction.fromMap(Map<String, dynamic> map) {
    return AppTransaction(
      id: map['id'] as String,
      pocketId: map['pocketId'] as String,
      toPocketId: map['toPocketId'] as String?,
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] as String,
      paymentMethod: map['paymentMethod'] as String,
      note: map['note'] as String?,
      type: TransactionType.values[map['type'] as int],
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }
}