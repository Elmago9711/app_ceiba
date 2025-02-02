// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';

class UserController {
  Future<void> fetchUsersFromAPI() async {
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'GET', Uri.parse('https://jsonplaceholder.typicode.com/users'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      List<dynamic> jsonData = json.decode(responseBody);

      Database db = await getDatabase();

      print("🔴 Conectado a la base de datos.");

      for (var user in jsonData) {
        Map<String, dynamic> userData = {
          'id': user['id'],
          'name': user['name'],
          'username': user['username'],
          'email': user['email'],
          'phone': user['phone'],
          'website': user['website'],
        };

        Map<String, dynamic> address = user['address'];

        Map<String, dynamic> geo = address['geo'];
        Map<String, dynamic> geoData = {
          'lat': geo['lat'],
          'lng': geo['lng'],
        };

        int geoId = await db.insert('Geo', geoData,
            conflictAlgorithm: ConflictAlgorithm.replace);

        // Ahora insertar en la tabla `Address`
        Map<String, dynamic> addressData = {
          'userId': user['id'], // Relación con Users
          'street': address['street'],
          'suite': address['suite'],
          'city': address['city'],
          'zipcode': address['zipcode'],
          'geoId': geoId, // Relación con Geo
        };

        await db.insert('Address', addressData,
            conflictAlgorithm: ConflictAlgorithm.replace);

        // Insertar en la tabla `Company`
        Map<String, dynamic> company = user['company'];
        Map<String, dynamic> companyData = {
          'userId': user['id'], // Relación con Users
          'name': company['name'],
          'catchPhrase': company['catchPhrase'],
          'bs': company['bs'],
        };

        await db.insert('Company', companyData,
            conflictAlgorithm: ConflictAlgorithm.replace);

        await db.insert('Users', userData,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      print("✅ Datos guardados correctamente en SQLite");
    } else {
      throw Exception('Error al obtener usuarios');
    }
  }

  Future<void> saveUsersToDatabase(List<dynamic> users) async {
    Database db = await openDatabase('Ceiba.db');

    for (var user in users) {
      int userId = await db.insert(
          'Users',
          {
            'id': user['id'],
            'name': user['name'],
            'username': user['username'],
            'email': user['email'],
            'phone': user['phone'],
            'website': user['website'],
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      await db.insert(
          'Address',
          {
            'userId': userId,
            'street': user['address']['street'],
            'suite': user['address']['suite'],
            'city': user['address']['city'],
            'zipcode': user['address']['zipcode'],
            'geoId': user['address']['geo']['id'],
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      await db.insert(
          'Geo',
          {
            'id': user['address']['geo']['id'],
            'lat': user['address']['geo']['lat'],
            'lng': user['address']['geo']['lng'],
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      await db.insert(
          'Company',
          {
            'userId': userId,
            'name': user['company']['name'],
            'catchPhrase': user['company']['catchPhrase'],
            'bs': user['company']['bs'],
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<Database> getDatabase() async {
    return openDatabase('Ceiba.db');
  }

  Future<List<User>> getUsersFromLocalDB() async {
    try {
      final Database db = await getDatabase();
      final List<Map<String, dynamic>> maps = await db.query('Users');

      if (maps.isEmpty) {
        print("No hay usuarios en la base de datos.");
        return [];
      }

      List<User> users = maps.map((map) => User.fromMap(map)).toList();
      print("Usuarios obtenidos: $users");

      return users;
    } catch (e) {
      print("Error al obtener usuarios: $e");
      return [];
    }
  }
}
