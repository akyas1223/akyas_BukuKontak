import 'package:flutter/material.dart';
import 'halaman_beranda.dart'; 
import 'halaman_tambah_kontak.dart'; 
import 'halaman_tentang.dart'; 

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
      initialRoute: '/',
      routes: {
        '/': (context) => const HalamanBeranda(),
        '/tambah_kontak': (context) => const HalamanTambahKontak(),
        '/tentang': (context) => const HalamanTentang(),
      },
    );
  }
}