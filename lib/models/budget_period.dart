enum PeriodType {
  weekly,
  monthly,
  custom,
}

extension PeriodTypeExtension on PeriodType {
  String get label {
    switch (this) {
      case PeriodType.weekly:
        return 'Weekly';
      case PeriodType.monthly:
        return 'Monthly';
      case PeriodType.custom:
        return 'Custom';
    }
  }
}

class BudgetPeriod {
  final PeriodType type;
  final DateTime startDate;
  final DateTime endDate;
  final double income;
  final double spent;
  final double saved;

  const BudgetPeriod({
    required this.type,
    required this.startDate,
    required this.endDate,
    this.income = 0,
    this.spent = 0,
    this.saved = 0,
  });

  double get remaining => income - spent - saved;

  int get daysRemaining =>
      endDate.difference(DateTime.now()).inDays.clamp(0, 365).toInt();

  double get progress {
    final total = endDate.difference(startDate).inDays;
    final elapsed = DateTime.now().difference(startDate).inDays;
    if (total <= 0) return 0;
    return (elapsed / total).clamp(0.0, 1.0);
  }
}