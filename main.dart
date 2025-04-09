import 'package:flutter/material.dart';
import 'quiz_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz GEN Z',
      theme: ThemeData(
        fontFamily: 'Arial',
      ),
      home: const QuizHomePage(),
    );
  }
}

class QuizHomePage extends StatelessWidget {
  const QuizHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF64C7FF), Color(0xFFE26D8B)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Quiz dengan Emoji
            ClipRRect(
              borderRadius: BorderRadius.circular(50), // Membuat gambar menjadi bulat
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover, // Menyesuaikan gambar agar sesuai dengan bentuk bulat
                ),
              ),
            ),

            // Title
            const Text(
              'QUIZ GEN Z',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            // Subtitle
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                'Kuis ini dirancang untuk menguji pemahaman dasar tentang konsep-konsep kunci dalam dunia komputer dan teknologi informasi. Yang mencakup berbagai topik penting seperti perangkat keras, perangkat lunak, sistem operasi, database, bahasa pemrograman, jaringan komputer, dan internet.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Button Start Quiz
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizPage()),
                );
              },
              child: const Text(
                'START QUIZ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 30),


          ],
        ),
      ),
    );
  }
}
