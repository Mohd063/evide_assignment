class Stop {
  final int id;
  final String name;
  final String description;
  final double lat;
  final double lng;

  Stop({
    required this.id,
    required this.name,
    required this.description,
    required this.lat,
    required this.lng,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}