import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RekomendasiSitusPage extends StatefulWidget {
  const RekomendasiSitusPage({super.key});

  @override
  State<RekomendasiSitusPage> createState() => _RekomendasiSitusPageState();
}

class _RekomendasiSitusPageState extends State<RekomendasiSitusPage> {
  final List<Map<String, dynamic>> _situsList = [
    {
      "judul": "Flutter",
      "deskripsi": "Toolkit UI open-source dari Google.",
      "gambar": "https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png",
      "link": "https://flutter.dev",
      "favorite": false,
    },
    {
      "judul": "GeeksForGeeks",
      "deskripsi": "Situs belajar pemrograman dan DSA.",
      "gambar": "https://upload.wikimedia.org/wikipedia/commons/e/eb/GeeksForGeeks_logo.png", 
      "favorite": false,
    },
    {
      "judul": "W3Schools",
      "deskripsi": "Tutorial pemrograman HTML, CSS, JS, dan lainnya.",
      "gambar": "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/W3Schools_logo.svg/1200px-W3Schools_logo.svg.png",
      "link": "https://www.w3schools.com",
      "favorite": false,
    },
  ];

  void _toggleFavorite(int index) {
    setState(() {
      _situsList[index]['favorite'] = !_situsList[index]['favorite'];
    });
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // warna icon back
        title: const Text('Rekomendasi Situs', style: TextStyle(color: Colors.white)), // warna teks title
        backgroundColor: Color.fromARGB(255, 15, 112, 223),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: _situsList.length,
        itemBuilder: (context, index) {
          final situs = _situsList[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    situs['gambar'],
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 160,
                        color: Colors.grey[300],
                        child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                      );
                    },
                  ),

                ),
                ListTile(
                  title: Text(situs['judul'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(situs['deskripsi']),
                  trailing: IconButton(
                    icon: Icon(
                      situs['favorite']
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: situs['favorite'] ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => _toggleFavorite(index),
                  ),
                ),
                OverflowBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => _launchURL(situs['link']),
                      child: const Text("KUNJUNGI SITUS"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
