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
  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        break;
    }
  }

  @override
  void initState() {
    _getAllPertanyaan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Fomus", style: TextStyle(color: Colors.black)),
        actions: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            decoration:const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fomus.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        backgroundColor:const Color.fromARGB(255, 100, 100, 100),
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
              contentPadding:const EdgeInsets.all(16),
              title: Text(
                '${pertanyaan.titleController}',
                style:const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.black),
              ),
              subtitle: Text('${pertanyaan.nameController}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  AlertDialog hapus = AlertDialog(
                    title: const Text('Information'),
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
                        child: const Text('Ya'),
                        onPressed: () {
                          // Delete
                          _deletePertanyaan(pertanyaan, index);
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: const Text('Tidak'),
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
                icon: const Icon(Icons.visibility),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.grey,
        onPressed: () {
          // Add
          _openFormCreate();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
  items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.book),
      label: ('Daftar'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: ('Beranda'),
    ),
  ],
  currentIndex: _selectedNavbar,
  selectedItemColor: Colors.black,
  unselectedItemColor: Colors.grey,
  onTap: _changeSelectedNavBar,
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
