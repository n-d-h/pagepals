import 'package:intl/intl.dart';

String formatTime(String timeString) {
  final now = DateTime.now();
  final time = DateTime.parse(timeString);
  final formatter = DateFormat.Hm(); // Format: HH:mm (hours and minutes)
  final yesterday = DateTime(now.year, now.month, now.day - 1);

  if (time.year == now.year && time.month == now.month && time.day == now.day) {
    // Today
    return formatter.format(time);
  } else if (time.year == yesterday.year &&
      time.month == yesterday.month &&
      time.day == yesterday.day) {
    // Yesterday
    return 'Yesterday ${formatter.format(time)}';
  } else {
    // Far from yesterday
    final fullFormatter =
        DateFormat('HH:mm dd-MM-yyyy'); // Format: HH:mm dd-MM-yyyy
    return fullFormatter.format(time);
  }
}
