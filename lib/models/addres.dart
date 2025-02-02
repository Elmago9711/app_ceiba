class Address {
  final int userId;
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final int? geoId;

  Address({
    required this.userId,
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    this.geoId,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      userId: map['userId'],
      street: map['street'],
      suite: map['suite'],
      city: map['city'],
      zipcode: map['zipcode'],
      geoId: map['geoId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'street': street,
      'suite': suite,
      'city': city,
      'zipcode': zipcode,
      'geoId': geoId,
    };
  }
}
