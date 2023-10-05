import 'dart:convert';
import 'dart:io';

import 'package:test_1/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Unsoed App CRUD',
      home: SplashScreen(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController jurusanController = TextEditingController();
  
  get http => null;

  Future postData(String nama, String jurusan) async {
    String url = Platform.isAndroid
        ? 'http://10.0.2.2/Flutter/index.php'
        : 'http://localhost/Flutter/index.php';

    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody = '{"nama": "$nama", "jurusan": "$jurusan"}';
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add data');
    }
  }

  Future updateData(int id, String nama, String jurusan) async {
    final response = await http.put(
      Uri.parse('http://localhost/api_flutter/index.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'id': id, 'nama': nama, 'jurusan': jurusan}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
