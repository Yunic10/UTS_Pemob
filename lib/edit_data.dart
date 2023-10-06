// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:test_1/list_data.dart';
import 'package:test_1/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {
  final dynamic id;
  const EditData({Key? key, required this.id}) : super(key: key);

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final namaController = TextEditingController();
  final jumlahController = TextEditingController();
  final catatanController = TextEditingController();

  String url = Platform.isAndroid
      ? 'http://10.0.2.2:70/Flutter1/index.php'
      : 'http://localhost:70/Flutter1/index.php';

  Future<dynamic> updateData(String id, String nama, int jumlah,String catatan) async {
    // print("updating");
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody = '{"id":$id,"nama": "$nama", "jumlah": "$jumlah" ,"catatan": "$catatan"}';
    var response = await http.put(Uri.parse("$url?id=$id"),
        headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add data');
    }
  }

  Future<dynamic> getData(dynamic id) async {
    final response = await http.get(Uri.parse("$url?id=$id"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        namaController.text = data['nama'];
        jumlahController.text= data['jumlah'];
        catatanController.text = data['catatan'];
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
      appBar: AppBar(
        title: const Text('Edit Data Transaksi'),
      ),
      drawer: const SideMenu(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                hintText: 'Nama Transaksi',
              ),
            ),
            TextField(
              controller: jumlahController,
              decoration: const InputDecoration(
                hintText: 'jumlah',
              ),
            ),
            TextField(
              controller: catatanController,
              decoration: const InputDecoration(
                hintText: 'catatan',
              ),
            ),
            ElevatedButton(
              child: const Text('Edit Transaksi'),
              onPressed: () {
                String nama = namaController.text;
                int jumlah = int.parse(jumlahController.text);
                String catatan = catatanController.text;

                // updateData(widget.id,nama, catatan);

                updateData(widget.id, nama, jumlah, catatan).then((result) {
                  print(result);
                  if (result['pesan'] == 'berhasil') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Data berhasil di ubah'),
                            content: const Text('ok'),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ListData(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        });
                  }
                });
              },
            ),
          ],
        ),

        //     ],
        //   ),
        // ),
      ),
    );
  }
}
