/// Utility for formatting byte sizes.
String formatBytes(int bytes, {int decimals = 2}) {
  if (bytes <= 0) return "0 Bytes";
  const suffixes = ["Bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  int i = 0;
  double size = bytes.toDouble();
  while (size >= 1024 && i < suffixes.length - 1) {
    size /= 1024;
    i++;
  }
  return "${size.toStringAsFixed(decimals)} ${suffixes[i]}";
}

/// Formats a duration into HH:MM:SS string.
String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}
