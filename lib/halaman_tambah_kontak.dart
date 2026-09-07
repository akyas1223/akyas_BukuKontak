import 'package:flutter/material.dart';

class HalamanTambahKontak extends StatefulWidget {
  const HalamanTambahKontak({super.key});

  @override
  State<HalamanTambahKontak> createState() => _HalamanTambahKontakState();
}

class _HalamanTambahKontakState extends State<HalamanTambahKontak> {
  // TUGAS 5: Menambahkan GlobalKey untuk FormState
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _noHpController = TextEditingController();
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
        // TUGAS 5: Membungkus Column dengan Form dan memasang formKey
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // TUGAS 5: Mengubah TextField menjadi TextFormField dan menambah validator
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email wajib diisi';
                  }
                  if (!value.contains('@')) {
                    return 'Email harus mengandung karakter @';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _noHpController,
                decoration: const InputDecoration(labelText: 'No Handphone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No Handphone wajib diisi';
                  }
                  if (double.tryParse(value) == null) {
                    return 'No Handphone hanya boleh angka';
                  }
                  if (value.length < 10) {
                    return 'No Handphone minimal 10 digit';
                  }
                  return null;
                },
              ),
              // Kategori dibiarkan tanpa validator karena opsional
              TextFormField(
                controller: _kategoriController,
                decoration: const InputDecoration(labelText: 'Kategori (Opsional)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TUGAS 5: Memeriksa validasi sebelum menyimpan
                  if (_formKey.currentState!.validate()) {
                    String? nilaiKategori = _kategoriController.text.isNotEmpty ? _kategoriController.text : null;

                    Navigator.pop(context, {
                      'nama': _namaController.text,
                      'email': _emailController.text,
                      'no_hp': _noHpController.text,
                      'kategori': nilaiKategori,
                    });
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}