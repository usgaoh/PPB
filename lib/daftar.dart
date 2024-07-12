import 'package:flutter/material.dart';
import 'package:fomus/database_helper.dart';
import 'package:fomus/pertanyaan.dart';
import 'package:fomus/detail_pertanyaan.dart';
import 'package:fomus/home.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({Key? key}) : super(key: key);

  @override
  _DaftarPageState createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  List<Pertanyaan> listPertanyaan = [];
  DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    _getAllPertanyaan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pertanyaan'),
      ),
      body: ListView.builder(
          itemCount: listPertanyaan.length,
          itemBuilder: (context, index) {
            Pertanyaan pertanyaan = listPertanyaan[index];

            return ListTile(
              onTap: () {
                // Edit
                _openFormEdit(pertanyaan);
              },
              contentPadding: EdgeInsets.all(16),
              title: Text(
                '${pertanyaan.titleController}',
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.deepOrangeAccent),
              ),
              subtitle: Text('${pertanyaan.nameController}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  AlertDialog hapus = AlertDialog(
                    title: Text('Information'),
                    content: Container(
                      height: 100,
                      child: Column(
                        children: [
                          Text(
                              'Apakah anda yakin ingin menghapus data ${pertanyaan.emailController}?'),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Ya'),
                        onPressed: () {
                          // Delete
                          _deletePertanyaan(pertanyaan, index);
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('Tidak'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                  showDialog(context: context, builder: (context) => hapus);
                },
              ),
              leading: IconButton(
                onPressed: () {
                  // Detail
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(pertanyaan)));
                },
                icon: Icon(Icons.visibility),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () {
          // Add
          _openFormCreate();
        },
      ),
    );
  }

  Future<void> _getAllPertanyaan() async {
    var list = await db.getAllPertanyaan();
    setState(() {
      listPertanyaan.clear();
      for (var pertanyaan in list!) {
        listPertanyaan.add(Pertanyaan.fromMap(pertanyaan));
      }
    });
    }

  Future<void> _deletePertanyaan(Pertanyaan pertanyaan, int position) async {
    await db.deletePertanyaan(pertanyaan.id!);

    setState(() {
      listPertanyaan.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Home()));
    if (result == 'save') {
      await _getAllPertanyaan();
    }
  }

  Future<void> _openFormEdit(Pertanyaan pertanyaan) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home(pertanyaan: pertanyaan)));
    if (result == 'update') {
      await _getAllPertanyaan();
    }
  }
}
