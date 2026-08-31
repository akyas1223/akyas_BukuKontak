import 'package:flutter/material.dart';
import 'halaman_beranda.dart'; 
import 'halaman_tambah_kontak.dart'; // Import halaman tambah kontak
import 'halaman_tentang.dart';       // Import halaman tentang

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buku Kontak',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Mengatur rute awal saat aplikasi pertama kali dibuka[cite: 1]
      initialRoute: '/',
      routes: {
        '/': (context) => const HalamanBeranda(),
        // Rute untuk halaman lain sekarang sudah diaktifkan[cite: 1, 2]
        '/tambah_kontak': (context) => const HalamanTambahKontak(),
        '/tentang': (context) => const HalamanTentang(),
      },
    );
  }
}