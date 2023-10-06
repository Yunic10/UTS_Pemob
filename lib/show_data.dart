import 'package:flutter/material.dart';
import 'package:test_1/side_menu.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class DetailTransaksi extends StatefulWidget {
  final dynamic id;
  const DetailTransaksi({super.key, this.id});

  @override
  State<DetailTransaksi> createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {
  Map<String, dynamic> dataTransaksi = {};
  String url = Platform.isAndroid
      ? 'http://10.0.2.2:70/Flutter1/index.php'
      : 'http://localhost:70/Flutter1/index.php';

  Future<dynamic> getData(dynamic id) async {
    final response = await http.get(Uri.parse("$url?id=$id"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        dataTransaksi = {"nama": data['nama'],"jumlah": data['jumlah'], "catatan": data['catatan']};
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
        title: Text("Detail Data Transaksi"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text("Nama Transaksi: ${dataTransaksi['nama']} "),
            SizedBox(height: 10,),
            Text("Jumlah Transaksi: ${dataTransaksi['jumlah']} "),
            SizedBox(height: 10,),
            Text("Catatan : ${dataTransaksi['catatan']}")
          ],
        ),
      ),
    );
  }
}
