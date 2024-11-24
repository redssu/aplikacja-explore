extension DateTimeExtension on DateTime {
  String get formattedDate => "$day.${month.toString().padLeft(2, "0")}.$year r.";
}
