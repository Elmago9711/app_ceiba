// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable

import 'package:flutter/material.dart';
import '../controllers/usercontroller.dart';
import '../models/user.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final UserController userController = UserController();
  List<User> userList = [];
  List<User> filteredUsers = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  /// 🔹 Cargar usuarios desde SQLite o API
  void loadUsers() async {
    await userController.fetchUsersFromAPI();
    List<User> users = await userController.getUsersFromLocalDB();

    setState(() {
      userList = users;
      filteredUsers = users;
      isLoading = false;
    });
  }

  /// 🔹 Filtrar usuarios según el texto ingresado
  void filterUsers(String query) {
    setState(() {
      filteredUsers = userList
          .where(
              (user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba de Ingreso'),
        titleTextStyle: TextStyle(
          color: Colors.white, // Color de la letra en blanco
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.green[700],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Pantalla de carga
          : Column(
              children: [
                // Campo de búsqueda
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Buscar usuario',
                      border: UnderlineInputBorder(),
                    ),
                    onChanged: filterUsers,
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(Icons.phone,
                                      size: 16, color: Colors.black54),
                                  SizedBox(width: 5),
                                  Text(user.phone),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.email,
                                      size: 16, color: Colors.black54),
                                  SizedBox(width: 5),
                                  Text(user.email),
                                ],
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/userDetails',
                                      arguments: user,
                                    );
                                  },
                                  child: Text(
                                    'VER PUBLICACIONES',
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
