import 'package:flutter/material.dart';
import 'package:fomus/pertanyaan.dart';

class DetailPage extends StatelessWidget {
  final Pertanyaan? pertanyaan;

  DetailPage(this.pertanyaan);

  @override
  Widget build(BuildContext context) {
    if (pertanyaan == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Page'),
        ),
        body: const Center(
          child: Text('No data available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Judul Formulir: ${pertanyaan!.titleController}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Nama: ${pertanyaan!.nameController}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Email: ${pertanyaan!.emailController}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Nomor Telp: ${pertanyaan!.phoneController}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Pertanyaan 1: ${pertanyaan!.question1Controller}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Pertanyaan 2: ${pertanyaan!.question2Controller}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Pertanyaan 3: ${pertanyaan!.question3Controller}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
