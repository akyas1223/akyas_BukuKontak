import 'package:flutter/material.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: const SizedBox(
        width: double.infinity, // Membuat konten berada tepat di tengah horizontal
        child: Column(
          children: [
            SizedBox(height: 40), // Jarak dari atas layar
            CircleAvatar(
              radius: 65, // Mengatur ukuran lingkarang foto
              // Memanggil gambar dari folder assets yang sudah didaftarkan
              backgroundImage: AssetImage('assets/profil.jpg'), 
            ),
            SizedBox(height: 24), // Jarak antara foto dan nama
            Text(
              'Mu\'ammar Akyas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16), // Jarak antar baris teks
            Text(
              'X PPLG A',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'SMK Negeri 5 Surakarta', // Silakan sesuaikan jika sekolahnya berbeda
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}