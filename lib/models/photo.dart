class Photo {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'],
      albumId: map['albumId'],
      title: map['title'],
      url: map['url'],
      thumbnailUrl: map['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'albumId': albumId,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}