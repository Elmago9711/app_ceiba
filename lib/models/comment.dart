class Comment {
  final int id;
  final int postId;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      postId: map['postId'],
      name: map['name'],
      email: map['email'],
      body: map['body'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postId': postId,
      'name': name,
      'email': email,
      'body': body,
    };
  }
}