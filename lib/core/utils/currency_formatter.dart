class CurrencyFormatter {
  /// Formats numbers into clean localized currency format.
  /// Example: 80000 -> "Rs. 80,000"
  static String format(double amount, {String symbol = 'Rs. '}) {
    final String digits = amount.toStringAsFixed(0);
    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final String formatted = digits.replaceAllMapped(
      reg,
      (Match m) => '${m[1]},',
    );
    return '$symbol$formatted';
  }

  /// Compact formatting for small UI cards or stats.
  /// Example: 150000 -> "Rs. 150k"
  static String formatCompact(double amount, {String symbol = 'Rs. '}) {
    if (amount >= 1000000) {
      return '$symbol${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '$symbol${(amount / 1000).toStringAsFixed(1)}k';
    }
    return '$symbol${amount.toStringAsFixed(0)}';
  }
}
