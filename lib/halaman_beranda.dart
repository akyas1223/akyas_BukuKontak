import 'package:flutter/material.dart';

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key});

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> with SingleTickerProviderStateMixin {
  List<Map<String, String>> daftarKontak = [];

  // 1. Menambahkan data fiko langsung ke list kontak favorit
  List<Map<String, String>> daftarFavorit = [
    {
      'nama': 'fiko',
      'email': 'fiko@gmail.com',
      'no_hp': '082220577493',
    },
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BUKU KONTAK'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
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
                _tabController.animateTo(0);
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
                  _tabController.animateTo(0);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Favorit'),
              onTap: () {
                Navigator.pop(context);
                _tabController.animateTo(1);
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
        controller: _tabController,
        children: [
          // Tampilan tab Utama Kontak
          daftarKontak.isEmpty
              ? const Center(child: Text('Belum ada kontak'))
              : ListView.builder(
                  itemCount: daftarKontak.length,
                  itemBuilder: (context, index) {
                    final item = daftarKontak[index];
                    
                    // TUGAS 3: Logika untuk mengambil inisial huruf pertama nama kontak
                    String inisial = item['nama'] != null && item['nama']!.isNotEmpty
                        ? item['nama']![0].toUpperCase()
                        : '?';

                    return ListTile(
                      // TUGAS 3: Mengubah Icon menjadi CircleAvatar
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        child: Text(
                          inisial,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(item['nama'] ?? ''),
                      subtitle: Text('${item['email']}\n${item['no_hp']}'),
                      isThreeLine: true,
                    );
                  },
                ),
                
          // Tampilan tab Favorit
          daftarFavorit.isEmpty
              ? const Center(child: Text('Belum ada kontak favorit'))
              : ListView.builder(
                  itemCount: daftarFavorit.length,
                  itemBuilder: (context, index) {
                    final item = daftarFavorit[index];
                    
                    // TUGAS 3: Logika untuk mengambil inisial huruf pertama nama kontak
                    String inisial = item['nama'] != null && item['nama']!.isNotEmpty
                        ? item['nama']![0].toUpperCase()
                        : '?';

                    return ListTile(
                      // TUGAS 3: Mengubah Icon menjadi CircleAvatar
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        child: Text(
                          inisial,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(item['nama'] ?? ''),
                      subtitle: Text('${item['email']}\n${item['no_hp']}'),
                      isThreeLine: true,
                    );
                  },
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/tambah_kontak');
          
          if (result != null && result is Map<String, String>) {
            setState(() {
              daftarKontak.add(result);
            });
            _tabController.animateTo(0); 
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}