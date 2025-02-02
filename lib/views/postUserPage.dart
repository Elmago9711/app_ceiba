// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import '../models/user.dart'; // Modelo User
import '../models/post.dart'; // Modelo Post
import '../controllers/postcontroller.dart'; // Controlador para obtener publicaciones

class UserDetailsPage extends StatefulWidget {
  final User user;

  // ignore: prefer_const_constructors_in_immutables
  UserDetailsPage({required this.user});

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late List<Post> posts;
  bool isLoading = true;

  final PostController postController = PostController();

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  // Cargar publicaciones del usuario
  void loadPosts() async {
    try {
      posts = await postController.getPostsByUserId(widget.user.id);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Manejar el error de carga
      print('Error al cargar publicaciones: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.user.name} - Publicaciones'),
        titleTextStyle: TextStyle(
          color: Colors.white, // Color de la letra en blanco
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.green[700],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre: ${widget.user.name}',
                      style: TextStyle(fontSize: 16)),
                  Text('Email: ${widget.user.email}',
                      style: TextStyle(fontSize: 16)),
                  Text('Teléfono: ${widget.user.phone}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Publicaciones:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(post.title,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text(post.body),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
