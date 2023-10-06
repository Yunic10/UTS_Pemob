import 'dart:convert';
import 'dart:io';

import 'package:test_1/list_data.dart';
import 'package:test_1/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahData extends StatefulWidget {
  const TambahData({Key? key}) : super(key: key);

  @override
  _TambahDataState createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final namaController = TextEditingController();
  final jumlahController = TextEditingController();
  final catatanController = TextEditingController();

  Future postData(String nama, int jumlah,String catatan) async {
    // print(nama);
    String url = Platform.isAndroid
        ? 'http://10.0.2.2:70/Flutter1/index.php'
        : 'http://localhost:70/Flutter1/index.php';

    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody = '{"nama": "$nama", "jumlah": "$jumlah" ,"catatan": "$catatan"}';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Transaksi'),
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
                hintText: 'Jumlah Transaksi',
              ),
            ),
            TextField(
              controller: catatanController,
              decoration: const InputDecoration(
                hintText: 'Catatan',
              ),
            ),
            ElevatedButton(
              child: const Text('Tambah Transaksi'),
              onPressed: () {
                print("Hello");
                String nama = namaController.text;
                int jumlah = int.parse(jumlahController.text);
                String catatan = catatanController.text;
                // print(nama);
                postData(nama, jumlah, catatan).then((result) {
                  //print(result['pesan']);
                  if (result['pesan'] == 'berhasil') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          //var namauser2 = namauser;
                          return AlertDialog(
                            title: const Text('Data berhasil di tambah'),
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
                  setState(() {});
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
