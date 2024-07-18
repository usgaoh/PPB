import 'package:flutter/material.dart';
import 'package:fomus/pertanyaan.dart';
import 'package:fomus/database_helper.dart';
import 'package:fomus/daftar.dart';

class Home extends StatefulWidget {
  final Pertanyaan? pertanyaan;

  Home({this.pertanyaan});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper db = DatabaseHelper();

  final _formKey = GlobalKey<FormState>();
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
          MaterialPageRoute(builder: (context) => const DaftarPage()),
        );
        break;
    }
  }

  TextEditingController? titleController;
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? phoneController;
  TextEditingController? question1Controller;
  TextEditingController? question2Controller;
  TextEditingController? question3Controller;

  @override
  void initState() {
    titleController = TextEditingController(
        text: widget.pertanyaan == null ? '' : widget.pertanyaan!.titleController);
    nameController = TextEditingController(
        text: widget.pertanyaan == null ? '' : widget.pertanyaan!.nameController);
    emailController = TextEditingController(
        text: widget.pertanyaan == null ? '' : widget.pertanyaan!.emailController);
    phoneController = TextEditingController(
        text: widget.pertanyaan == null ? '' : widget.pertanyaan!.phoneController);
    question1Controller = TextEditingController(
        text: widget.pertanyaan == null ? '' : widget.pertanyaan!.question1Controller);
    question2Controller = TextEditingController(
        text: widget.pertanyaan == null ? '' : widget.pertanyaan!.question2Controller);
    question3Controller = TextEditingController(
        text: widget.pertanyaan == null ? '' : widget.pertanyaan!.question3Controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 100, 100, 100),
      appBar: AppBar(
        title: const Text("Fomus", style: TextStyle(color: Colors.black)),
        actions: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fomus.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        key: _formKey,
        child: Container(
          width: 500,
          height: 612,
          margin: const EdgeInsets.fromLTRB(50, 100, 50, 100),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
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
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Formulir tanpa judul",
                  labelText: "Judul formulir",
                ),
              ),

              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Masukan Nama",
                  labelText: "Nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),

              SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Masukan Email",
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),

              SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: "Masukan Nomor Telp",
                  labelText: "Nomor Telp",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),

              SizedBox(height: 16),
              TextField(
                controller: question1Controller,
                decoration: InputDecoration(
                  hintText: "Pertanyaan tanpa judul",
                  labelText: "Pertanyaan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),

              SizedBox(height: 16),
              TextField(
                controller: question2Controller,
                decoration: InputDecoration(
                  hintText: "Pertanyaan tanpa judul",
                  labelText: "Pertanyaan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),

              SizedBox(height: 16),
              TextField(
                controller: question3Controller,
                decoration: InputDecoration(
                  hintText: "Pertanyaan tanpa judul",
                  labelText: "Pertanyaan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              ElevatedButton(
                child: (widget.pertanyaan == null)
                    ? const Text(
                        'Tambah',
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                style: style,
                onPressed: () {
                  upsertPertanyaan();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ('Beranda'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: ('Daftar'),
          ),
        ],
        currentIndex: _selectedNavbar,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _changeSelectedNavBar,
      ),
    );
  }

  Future<void> upsertPertanyaan() async {
    if (widget.pertanyaan != null) {
      await db.updatePertanyaan(Pertanyaan(
          id: widget.pertanyaan!.id,
          titleController: titleController!.text,
          nameController: nameController!.text,
          emailController: emailController!.text,
          phoneController: phoneController!.text,
          question1Controller: question1Controller!.text,
          question2Controller: question2Controller!.text,
          question3Controller: question3Controller!.text));
      Navigator.pop(context, 'update');
    } else {
      await db.savePertanyaan(Pertanyaan(
          titleController: titleController!.text,
          nameController: nameController!.text,
          emailController: emailController!.text,
          phoneController: phoneController!.text,
          question1Controller: question1Controller!.text,
          question2Controller: question2Controller!.text,
          question3Controller: question3Controller!.text));
      Navigator.pop(context, 'save');
    }
  }
}
