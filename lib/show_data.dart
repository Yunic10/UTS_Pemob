import 'package:flutter/material.dart';
import 'package:test_1/side_menu.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class DetailMahasiswa extends StatefulWidget {
  final dynamic id;
  const DetailMahasiswa({super.key, this.id});

  @override
  State<DetailMahasiswa> createState() => _DetailMahasiswaState();
}

class _DetailMahasiswaState extends State<DetailMahasiswa> {
  Map<String, dynamic> dataMahasiswa = {};
  String url = Platform.isAndroid
      ? 'http://10.0.2.2:70/Flutter/index.php'
      : 'http://localhost:70/Flutter/index.php';

  Future<dynamic> getData(dynamic id) async {
    final response = await http.get(Uri.parse("$url?id=$id"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        dataMahasiswa = {"nama": data['nama'], "jurusan": data['jurusan']};
      });
    } else {
      return null;
    }
  }

  @override
  void initState() {
    getData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Detail Data Mahasiswa"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text("Nama : ${dataMahasiswa['nama']} "),
            SizedBox(height: 10,),
            Text("Jurusan : ${dataMahasiswa['jurusan']}")
          ],
        ),
      ),
    );
  }
}
