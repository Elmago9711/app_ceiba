class Album {
  final int id;
  final int userId;
  final String title;

  Album({
    required this.id,
    required this.userId,
    required this.title,
  });

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
    };
  }
}
