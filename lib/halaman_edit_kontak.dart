import 'package:flutter/material.dart';

class HalamanEditKontak extends StatefulWidget {
  // Menerima data kontak yang akan diedit dari halaman sebelumnya
  final Map<String, dynamic> kontak;

  const HalamanEditKontak({super.key, required this.kontak});

  @override
  State<HalamanEditKontak> createState() => _HalamanEditKontakState();
}

class _HalamanEditKontakState extends State<HalamanEditKontak> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _namaController;
  late TextEditingController _emailController;
  late TextEditingController _noHpController;
  late TextEditingController _kategoriController;

  @override
  void initState() {
    super.initState();
    // Mengisi form dengan data lama yang sudah tersimpan
    _namaController = TextEditingController(text: widget.kontak['nama']);
    _emailController = TextEditingController(text: widget.kontak['email']);
    _noHpController = TextEditingController(text: widget.kontak['no_hp']);
    _kategoriController = TextEditingController(text: widget.kontak['kategori'] ?? '');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _noHpController.dispose();
    _kategoriController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Kontak'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
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
                    return 'Email tidak boleh kosong';
                  }
                  if (!value.contains('@')) {
                    return 'Email harus menggunakan karakter @';
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
                    return 'Nomor handphone tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Nomor handphone hanya boleh berupa angka';
                  }
                  if (value.length < 10) {
                    return 'Nomor handphone minimal 10 digit';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kategoriController,
                decoration: const InputDecoration(labelText: 'Kategori (Opsional)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String? nilaiKategori = _kategoriController.text.isNotEmpty ? _kategoriController.text : null;

                    // Mengembalikan data baru ke halaman beranda
                    Navigator.pop(context, {
                      'nama': _namaController.text,
                      'email': _emailController.text,
                      'no_hp': _noHpController.text,
                      'kategori': nilaiKategori,
                    });
                  }
                },
                child: const Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}