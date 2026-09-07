import 'dart:async'; // TUGAS 6: Import library untuk Stream
import 'package:flutter/material.dart';

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key});

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> daftarKontak = [];

  List<Map<String, dynamic>> daftarFavorit = [
    {
      'nama': 'fiko',
      'email': 'fiko@gmail.com',
      'no_hp': '082220577493',
      'kategori': 'Teman',
    },
  ];

  late TabController _tabController;

  // TUGAS 6: Membuat StreamController dan TextEditingController untuk pencarian
  final StreamController<String> _searchController = StreamController<String>.broadcast();
  final TextEditingController _searchInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TUGAS 6: Menutup stream controller saat halaman dihancurkan untuk mencegah memory leak
    _searchController.close();
    _searchInputController.dispose();
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
                if (result != null && result is Map<String, dynamic>) {
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
          // TUGAS 6: Memodifikasi tab Utama Kontak dengan Column untuk menambahkan TextField pencarian
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchInputController,
                  decoration: const InputDecoration(
                    labelText: 'Cari Kontak (Nama / Kategori)',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (text) {
                    // Mengirimkan teks yang diketik ke dalam stream
                    _searchController.add(text);
                  },
                ),
              ),
              Expanded(
                // Menggunakan StreamBuilder untuk mendengarkan perubahan pada stream pencarian
                child: StreamBuilder<String>(
                  stream: _searchController.stream,
                  builder: (context, snapshot) {
                    // Mengambil kata kunci pencarian, ubah ke huruf kecil
                    String query = snapshot.data?.toLowerCase() ?? '';

                    // Menyaring daftarKontak berdasarkan Nama ATAU Kategori
                    List<Map<String, dynamic>> filteredList = daftarKontak.where((kontak) {
                      bool matchNama = (kontak['nama'] ?? '').toLowerCase().contains(query);
                      bool matchKategori = (kontak['kategori'] ?? '').toLowerCase().contains(query);
                      return matchNama || matchKategori;
                    }).toList();

                    if (filteredList.isEmpty && daftarKontak.isNotEmpty) {
                      return const Center(child: Text('Kontak tidak ditemukan'));
                    }

                    return filteredList.isEmpty
                        ? const Center(child: Text('Belum ada kontak'))
                        : ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              final item = filteredList[index];
                              
                              String inisial = item['nama'] != null && item['nama'].isNotEmpty
                                  ? item['nama'][0].toUpperCase()
                                  : '?';

                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  child: Text(
                                    inisial,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                title: Text(item['nama'] ?? ''),
                                subtitle: Text('${item['email']}\n${item['no_hp']}\nKategori: ${item['kategori'] ?? 'Tanpa kategori'}'),
                                isThreeLine: true,
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
                
          // Tampilan tab Favorit
          daftarFavorit.isEmpty
              ? const Center(child: Text('Belum ada kontak favorit'))
              : ListView.builder(
                  itemCount: daftarFavorit.length,
                  itemBuilder: (context, index) {
                    final item = daftarFavorit[index];
                    
                    String inisial = item['nama'] != null && item['nama'].isNotEmpty
                        ? item['nama'][0].toUpperCase()
                        : '?';

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        child: Text(
                          inisial,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(item['nama'] ?? ''),
                      subtitle: Text('${item['email']}\n${item['no_hp']}\nKategori: ${item['kategori'] ?? 'Tanpa kategori'}'),
                      isThreeLine: true,
                    );
                  },
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/tambah_kontak');
          
          if (result != null && result is Map<String, dynamic>) {
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