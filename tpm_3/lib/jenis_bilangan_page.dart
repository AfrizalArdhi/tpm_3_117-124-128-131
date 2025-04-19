import 'package:flutter/material.dart';

class JenisBilanganPage extends StatefulWidget {
  const JenisBilanganPage({super.key});

  @override
  State<JenisBilanganPage> createState() => _JenisBilanganPageState();
}

class _JenisBilanganPageState extends State<JenisBilanganPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> resultList = [];

  bool isPrime(int number) {
    if (number < 2) return false;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  void classifyNumber(String input) {
    setState(() {
      resultList.clear();
      try {
        double value = double.parse(input);
        int intValue = int.tryParse(input) ?? value.toInt();

        if (value != intValue) {
          resultList.add("Desimal");
        } else {
          if (intValue < 0) resultList.add("Bulat Negatif");
          if (intValue == 0) resultList.add("Cacah");
          if (intValue > 0) resultList.add("Bulat Positif");

          if (intValue >= 0) resultList.add("Cacah");
          if (intValue >= 1 && isPrime(intValue)) resultList.add("Prima");
        }
      } catch (e) {
        resultList = ["Masukkan angka yang valid."];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // warna icon back
        title: const Text('Jenis Bilangan', style: TextStyle(color: Colors.white)), // warna teks title
        backgroundColor: Color.fromARGB(255, 15, 112, 223),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
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
              child: ElevatedButton(
                onPressed: () => classifyNumber(_controller.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 15, 112, 223),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text(
                  "Cek Jenis Bilangan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),
            if (resultList.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: resultList
                    .map((item) => Text(
                          "• $item",
                          style: const TextStyle(fontSize: 16),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
