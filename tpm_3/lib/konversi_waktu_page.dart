import 'package:flutter/material.dart';

class KonversiWaktuPage extends StatefulWidget {
  const KonversiWaktuPage({super.key});

  @override
  State<KonversiWaktuPage> createState() => _KonversiWaktuPageState();
}

class _KonversiWaktuPageState extends State<KonversiWaktuPage> {
  final TextEditingController _tahunController = TextEditingController();
  String _hasil = "";

  void _konversiWaktu() {
    final int? tahun = int.tryParse(_tahunController.text);
    if (tahun != null && tahun >= 0) {
      int jam = tahun * 365 * 24;
      int menit = jam * 60;
      int detik = menit * 60;

      setState(() {
        _hasil =
            "$tahun tahun setara dengan:\n• $jam jam\n• $menit menit\n• $detik detik";
      });
    } else {
      setState(() {
        _hasil = "Masukkan angka tahun yang valid.";
      });
    }
  }

  @override
  void dispose() {
    _tahunController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // warna icon back
        title: const Text('Konversi Waktu', style: TextStyle(color: Colors.white)), // warna teks title
        backgroundColor: Color.fromARGB(255, 15, 112, 223),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.access_time, size: 70, color: Colors.blueAccent),
            const SizedBox(height: 20),
            const Text(
              "Masukkan jumlah tahun",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _tahunController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Tahun",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue), // border normal
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0), // border saat fokus
                ),
              ),

            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _konversiWaktu,
                icon: const Icon(Icons.refresh, color: Colors.white), // ikon jadi putih
                label: const Text("Konversi", style: TextStyle(color: Colors.white)), // teks jadi putih
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),

            ),
            const SizedBox(height: 30),
            if (_hasil.isNotEmpty)
              Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _hasil,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
