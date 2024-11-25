class LocationModel {
  final String place;
  final String placeShort;
  final String address;
  final String city;
  final double latitude;
  final double longitude;

  LocationModel({
    required this.place,
    String? placeShort,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
  }) : placeShort = placeShort ?? place;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      place: json["place"] as String,
      placeShort: (json["placeShort"] as String?) ?? json["place"] as String,
      address: json["address"] as String,
      city: json["city"] as String,
      latitude: json["latitude"] as double,
      longitude: json["longitude"] as double,
    );
  }

  String get shortAddress => "$placeShort, $city";
}
