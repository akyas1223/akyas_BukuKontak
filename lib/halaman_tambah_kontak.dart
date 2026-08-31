import 'package:flutter/material.dart';

class HalamanTambahKontak extends StatefulWidget {
  const HalamanTambahKontak({super.key});

  @override
  State<HalamanTambahKontak> createState() => _HalamanTambahKontakState();
}

class _HalamanTambahKontakState extends State<HalamanTambahKontak> {
  // Controller untuk menangkap inputan dari form
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _noHpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kontak'),
        backgroundColor: Colors.blue, // Mengubah AppBar menjadi biru
        foregroundColor: Colors.white, // Mengubah teks dan ikon AppBar menjadi putih
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama Lengkap'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _noHpController,
              decoration: const InputDecoration(labelText: 'No Handphone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Mengirim data form kembali ke halaman Beranda
                Navigator.pop(context, {
                  'nama': _namaController.text,
                  'email': _emailController.text,
                  'no_hp': _noHpController.text,
                });
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}