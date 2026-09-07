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
  
  // TUGAS 4: Tambahan controller untuk menangkap input kategori
  final _kategoriController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kontak'),
        backgroundColor: Colors.blue, 
        foregroundColor: Colors.white, 
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
            // TUGAS 4: Tambahan input TextField untuk Kategori yang bersifat opsional
            TextField(
              controller: _kategoriController,
              decoration: const InputDecoration(labelText: 'Kategori (Opsional)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TUGAS 4: Mengirimkan null jika kategori dikosongkan agar bisa dicek dengan Null Safety
                String? nilaiKategori = _kategoriController.text.isNotEmpty ? _kategoriController.text : null;

                // Mengirim data form kembali ke halaman Beranda
                Navigator.pop(context, {
                  'nama': _namaController.text,
                  'email': _emailController.text,
                  'no_hp': _noHpController.text,
                  'kategori': nilaiKategori, // Menambahkan kategori ke data yang dikirim
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