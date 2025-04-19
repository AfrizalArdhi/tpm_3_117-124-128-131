import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Stopwatch stopwatch = Stopwatch();
  late Timer timer;

  String formattedTime() {
    final duration = stopwatch.elapsed;
    return "${duration.inMinutes.toString().padLeft(2, '0')}:"
        "${(duration.inSeconds % 60).toString().padLeft(2, '0')}:"
        "${(duration.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0')}";
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void stopTimer() {
    timer.cancel();
  }

  @override
  void dispose() {
    if (stopwatch.isRunning) stopwatch.stop();
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(milliseconds: 0), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // warna icon back
        title: const Text('Stopwatch', style: TextStyle(color: Colors.white)), // warna teks title
        backgroundColor: const Color.fromARGB(255, 15, 112, 223),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formattedTime(),
              style: const TextStyle(
                fontSize: 64, // diperbesar
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircleButton(
                  icon: Icons.play_arrow,
                  onPressed: () {
                    if (!stopwatch.isRunning) {
                      stopwatch.start();
                      startTimer();
                    }
                  },
                  color: Colors.white,
                ),
                const SizedBox(width: 20),
                _buildCircleButton(
                  icon: Icons.pause,
                  onPressed: () {
                    if (stopwatch.isRunning) {
                      stopwatch.stop();
                      stopTimer();
                    }
                  },
                  color: Colors.white,
                ),
                const SizedBox(width: 20),
                _buildCircleButton(
                  icon: Icons.refresh,
                  onPressed: () {
                    stopwatch.reset();
                    setState(() {});
                  },
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        backgroundColor: color,
        foregroundColor: Colors.black,
        elevation: 5,
      ),
      child: Icon(icon, size: 28),
    );
  }
}
