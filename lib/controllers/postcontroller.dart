import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostController {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // Obtener las publicaciones por userId
  Future<List<Post>> getPostsByUserId(int userId) async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // Si la respuesta es exitosa, parseamos el JSON
      List<dynamic> postsJson = json.decode(response.body);

      // Filtrar las publicaciones por userId
      List<Post> posts = postsJson
          .where((post) => post['userId'] == userId)
          .map((post) => Post.fromMap(post))
          .toList();

      return posts;
    } else {
      throw Exception('Error al cargar publicaciones');
    }
  }
}
