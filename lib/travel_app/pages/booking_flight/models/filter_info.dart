class FilterInfo {
  final String departureDate;
  final String from;
  final String to;
  final List<String> cls;
   List<dynamic> seats;
  FilterInfo(
      {required this.departureDate,
      required this.from,
      required this.to,
      required this.cls,
      required this.seats});
}
