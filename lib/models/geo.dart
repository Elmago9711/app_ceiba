class Geo {
  final int? id;
  final String lat;
  final String lng;

  Geo({this.id, required this.lat, required this.lng});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lat': lat,
      'lng': lng,
    };
  }

  factory Geo.fromMap(Map<String, dynamic> map) {
    return Geo(
      id: map['id'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }
}
