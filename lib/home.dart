import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  final _formKey = GlobalKey<FormState>();


bool nilaiCheckBox = false;
bool nilaiSwitch = false;

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Color.fromARGB(255, 100, 100, 100),

      appBar: new AppBar(
        leading: new Icon(Icons.menu, size: 30, color: Colors.black),
        title: new Text("Fomus",
        style:TextStyle(color: Colors.black)),
        actions: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage("assets/images/fomus.jpg"))
            ),
          ),
        ],
        backgroundColor: Colors.white,
        ),

      body: ListView(
        children: [
          Container(
            width: 500,
            height: 600,
            margin: const EdgeInsets.fromLTRB(50, 100, 50, 100),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
          
            child: new Column(
              children: <Widget>[
          
                TextField(
                  decoration: new InputDecoration(
                    hintText: "Formulir tanpa judul",
                    labelText: "Judul formulir",
                  ),
                ),
          
              new Padding(padding: new EdgeInsets.only(top: 50.0),),
                TextField(
                  decoration: new InputDecoration(
                    hintText: "Pertanyaan tanpa judul",
                    labelText: "Pertanyaan",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0)
                    )
                  ),
                ),
          
              new Padding(padding: new EdgeInsets.only(top: 20.0),),
                TextField(
                  decoration: new InputDecoration(
                    hintText: "Pertanyaan tanpa judul",
                    labelText: "Pertanyaan",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0)
                    )
                  ),
                ),
          
                new Padding(padding: new EdgeInsets.only(top: 20.0),),
                CheckboxListTile(
                  title: Text('Opsi 1'),
                  value: nilaiCheckBox,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      nilaiCheckBox = value!;
                    });
                  },
                ),

                new Padding(padding: new EdgeInsets.only(top: 20.0),),
                SwitchListTile(
                  title: Text('Wajib diisi'),
                  value: nilaiSwitch,
                  activeTrackColor: Colors.white,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      nilaiSwitch = value;
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
                      // Perform some action
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