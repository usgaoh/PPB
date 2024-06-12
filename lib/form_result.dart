import 'package:flutter/material.dart';

class FormResultPage extends StatelessWidget {
  final String formTitle;

  FormResultPage({required this.formTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(formTitle),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Text(
          'Hasil formulir akan ditampilkan di sini',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
