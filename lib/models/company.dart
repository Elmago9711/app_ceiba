class Company {
  final int userId;
  final String name;
  final String catchPhrase;
  final String bs;

  Company({
    required this.userId,
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      userId: map['userId'],
      name: map['name'],
      catchPhrase: map['catchPhrase'],
      bs: map['bs'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'catchPhrase': catchPhrase,
      'bs': bs,
    };
  }
}
