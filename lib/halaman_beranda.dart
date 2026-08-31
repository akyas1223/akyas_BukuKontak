import 'package:flutter/material.dart';

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key});

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

// 1. Tambahkan 'with SingleTickerProviderStateMixin' agar bisa menggunakan animasi Tab
class _HalamanBerandaState extends State<HalamanBeranda> with SingleTickerProviderStateMixin {
  List<Map<String, String>> daftarKontak = [];

  // 2. Buat variabel TabController
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 3. Inisialisasi TabController dengan jumlah tab = 2
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // 4. Buang controller saat halaman ditutup agar aplikasi tidak berat (memory leak)
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DefaultTabController dihapus, langsung gunakan Scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text('BUKU KONTAK'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController, // Hubungkan TabBar dengan controller manual
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.account_circle), text: 'Kontak'),
            Tab(icon: Icon(Icons.star), text: 'Favorit'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'BUKU KONTAK',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: const Text('Kontak'),
              onTap: () {
                Navigator.pop(context);
                _tabController.animateTo(0); // Memaksa pindah ke tab Kontak saat diklik
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Tambah Kontak'),
              onTap: () async {
                Navigator.pop(context);
                final result = await Navigator.pushNamed(context, '/tambah_kontak');
                if (result != null && result is Map<String, String>) {
                  setState(() {
                    daftarKontak.add(result);
                  });
                  _tabController.animateTo(0); // Memaksa pindah ke tab Kontak setelah simpan
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Favorit'),
              onTap: () {
                Navigator.pop(context);
                _tabController.animateTo(1); // Memaksa pindah ke tab Favorit saat diklik
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Tentang'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/tentang');
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController, // Hubungkan TabBarView dengan controller manual
        children: [
          // Tampilan tab Kontak
          daftarKontak.isEmpty
              ? const Center(child: Text('Belum ada kontak'))
              : ListView.builder(
                  itemCount: daftarKontak.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.person, size: 40),
                      title: Text(daftarKontak[index]['nama']!),
                      subtitle: Text('${daftarKontak[index]['email']!}\n${daftarKontak[index]['no_hp']!}'),
                      isThreeLine: true,
                    );
                  },
                ),
          // Tampilan tab Favorit
          const Center(child: Text('Belum ada kontak favorit')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Menunggu data dari Halaman Tambah Kontak[cite: 1]
          final result = await Navigator.pushNamed(context, '/tambah_kontak');
          
          if (result != null && result is Map<String, String>) {
            setState(() {
              daftarKontak.add(result);
            });
            // PERINTAH INI YANG MEMAKSA PINDAH KE TAB KONTAK
            _tabController.animateTo(0); 
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}