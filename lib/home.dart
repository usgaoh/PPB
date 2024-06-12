import 'package:flutter/material.dart';
import 'package:fomus/form_result.dart'; // Import halaman baru

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  bool nilaiCheckBox1 = false;
  bool nilaiCheckBox2 = false;
  bool nilaiSwitch1 = true;
  bool nilaiSwitch2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 100, 100, 100),
      appBar: AppBar(
        leading: Icon(Icons.menu, size: 30, color: Colors.black),
        title: Text("Fomus", style: TextStyle(color: Colors.black)),
        actions: [
          Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage("assets/images/fomus.jpg"))),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: ListView(
        key: _formKey,
        children: [
          Container(
            width: 500,
            height: 600,
            margin: EdgeInsets.fromLTRB(50, 100, 50, 100),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: 3,
                  blurRadius: 15,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: "Formulir tanpa judul",
                    labelText: "Judul formulir",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Pertanyaan tanpa judul",
                      labelText: "Pertanyaan",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tidak dapat kosong';
                      }
                      return null;
                    },
                  ),
                ),
                SwitchListTile(
                  title: Text('Wajib diisi'),
                  value: nilaiSwitch1,
                  activeTrackColor: Colors.grey,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      nilaiSwitch1 = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Pertanyaan tanpa judul",
                      labelText: "Pertanyaan",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tidak dapat kosong';
                      }
                      return null;
                    },
                  ),
                ),
                SwitchListTile(
                  title: Text('Wajib diisi'),
                  value: nilaiSwitch2,
                  activeTrackColor: Colors.grey,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      nilaiSwitch2 = value;
                    });
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                CheckboxListTile(
                  title: Text('Opsi 1'),
                  value: nilaiCheckBox1,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      nilaiCheckBox1 = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Opsi 2'),
                  value: nilaiCheckBox2,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      nilaiCheckBox2 = value!;
                    });
                  },
                ),
                ElevatedButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Navigasi ke halaman baru dengan hasil formulir
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormResultPage(
                            formTitle: "Hasil Formulir",
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
