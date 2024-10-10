import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'widgets/home.dart';

Future<dynamic> getData() async {
  var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
  var data = json.decode(response.body);
  return data[0]['id'];
  } else {
    throw Exception('Échec de la récupération des données.');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
      body: Home(),
    ),
    );
  }
}