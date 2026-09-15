String formatMoney(double amount, {String currency = 'Rs.'}) {
  return '$currency ${amount.toStringAsFixed(amount == amount.roundToDouble() ? 0 : 2)}';
}

String formatAmount(double amount) {
  return amount.toStringAsFixed(amount == amount.roundToDouble() ? 0 : 2);
}

String formatDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  return '${date.day} ${months[date.month - 1]}, ${date.year}';
}

String formatTime(DateTime date) {
  var h = date.hour;
  final meridian = h >= 12 ? 'PM' : 'AM';
  h = h % 12;
  if (h == 0) h = 12;
  final minute = date.minute.toString().padLeft(2, '0');
  return '$h:$minute $meridian';
}

String timeAgo(DateTime date) {
  final diff = DateTime.now().difference(date);
  if (diff.inSeconds < 60) return 'just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays < 7) return '${diff.inDays}d ago';
  return formatDate(date);
}