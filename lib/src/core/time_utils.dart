String two(int n) => n.toString().padLeft(2, '0');

String formatHhMmSs(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes.remainder(60);
  final s = d.inSeconds.remainder(60);
  if (h > 0) {
    return '${two(h)}:${two(m)}:${two(s)}';
  }
  return '${two(m)}:${two(s)}';
}

String formatHm(DateTime dt) {
  final h = two(dt.hour);
  final m = two(dt.minute);
  return '$h:$m';
}

String formatDurationShort(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes.remainder(60);
  if (h > 0 && m > 0) return '${h}h${m}';
  if (h > 0) return '${h}h';
  return '${m} min';
}
