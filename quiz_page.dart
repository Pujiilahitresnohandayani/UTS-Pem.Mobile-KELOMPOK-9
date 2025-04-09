import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

// Halaman Utama
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF64C7FF), Color(0xFFE26D8B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ElevatedButton(
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
        ),
      ),
    );
  }
}

// Halaman Hasil
class ResultPage extends StatelessWidget {
  final int score;
  final int wrongAnswers;

  const ResultPage({super.key, required this.score, required this.wrongAnswers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
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
            const Text(
              'Hasil Quiz',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Nilai Anda: $score',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Soal yang Salah: $wrongAnswers',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Main Lagi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan, foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Class untuk pertanyaan (Abstraction)
class Question {
  final String questionText;
  final List<String> answers;
  final int correctIndex;

  Question({
    required this.questionText,
    required this.answers,
    required this.correctIndex,
  });

  bool isCorrect(int selectedIndex) {
    return selectedIndex == correctIndex;
  }
}

// Halaman Quiz
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _selectedAnswer = -1;
  int _timeLeft = 30;
  late Timer _timer;
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _wrongAnswers = 0; // Menambahkan variabel untuk menghitung jawaban salah

  // Pertanyaan disimpan menggunakan List<Question> untuk Abstraksi dan Encapsulasi
  final List<Question> questions = [
    Question(
      questionText: 'Apa itu perangkat keras komputer?',
      answers: [
        'Program yang diinstal di komputer',
        'Komponen fisik komputer seperti CPU dan RAM',
        'Sistem operasi yang digunakan dalam komputer',
        'Kumpulan data dalam komputer',
      ],
      correctIndex: 1,
    ),
    Question(
      questionText: 'Manakah yang merupakan contoh sistem operasi',
      answers: [
        'Microsoft Excel',
        'Windows 10',
        'Google Chrome',
        'Photoshop',
      ],
      correctIndex: 1,
    ),
    Question(
      questionText: 'Apa fungsi utama dari database?',
      answers: [
        'Mengedit gambar',
        'Menyimpan dan mengelola data',
        'Memperbaiki perangkat keras',
        'Menjalankan sistem operasi',
      ],
      correctIndex: 1,
    ),
    Question(
      questionText: 'Manakah yang merupakan bahasa pemrograman?',
      answers: [
        'Python',
        'Microsoft Word',
        'Google Drive',
        'Windows',
      ],
      correctIndex: 0,
    ),
    // ... (Pertanyaan lainnya)
    Question(
      questionText: 'Apa kepanjangan dari CPU??',
      answers: [
        'Central Processing Unit',
        'Computer Personal Unit',
        'Central Programming Utility',
        'Core Processing Unit'
      ],
      correctIndex: 0,
    ),
    Question(
      questionText: 'Perangkat Lunak ( Software ) adalah ??',
      answers: [
        'Komponen Fisik Komputer',
        'Progam yang digunkaan untuk menjalankan komputer',
        'Alat untuk membersihkan komputer',
        'Bagian dari CPU'
      ],
      correctIndex: 0,
    ),
    Question(
      questionText: 'Manakah yang termauk contoh perangkat keras??',
      answers: [
        'Google Chrome',
        'Windows 11',
        'Mouse dan Keyboard',
        'Microsoft Excell'
      ],
      correctIndex: 0,
    ),
    Question(
      questionText: 'Apa kegunaan utama jaringan komputer??',
      answers: [
        'Menghubungkan komputer untuk berbagi data',
        'Menambah Kapaistas penyimpanan komputer',
        'Mempercepat kinerja komputer',
        'Menghapus virus dari komputer'
      ],
      correctIndex: 0,
    ),
    Question(
      questionText: 'Manakah yang merupakan media penyimpanan data??',
      answers: [
        'Hard disk',
        'Monitor',
        'Printer',
        'Keyboard'
      ],
      correctIndex: 0,
    ),
    Question(
      questionText: 'Internet adalah ??',
      answers: [
        'Jaringan global yang menghubungkan komputer di seluruh dunia',
        'Sebuah perangkat keras komputer',
        'Sistem operasi komputer',
        'Program untuk membuat dokumen'
      ],
      correctIndex: 0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        timer.cancel(); // Hentikan timer
        print("Timer habis, pindah ke pertanyaan berikutnya");
        _nextQuestion(); // Otomatis lanjut ke pertanyaan berikutnya
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _selectAnswer(int index) {
    setState(() {
      _selectedAnswer = index;
    });
  }

  void _nextQuestion() {
    if (_selectedAnswer == -1) {
      _wrongAnswers++; // Tambahkan jawaban salah jika user tidak memilih
    } else if (!questions[_currentQuestionIndex].isCorrect(_selectedAnswer)) {
      _wrongAnswers++; // Tambahkan jawaban salah jika user memilih jawaban yang keliru
    } else {
      _score++; // Tambahkan skor jika jawabannya benar
    }

    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = -1;
        _timeLeft = 30;
      });

      _timer?.cancel(); // Hentikan timer sebelum memulai yang baru
      _startTimer();

    } else {
      _timer?.cancel(); // Hentikan timer sebelum pindah halaman
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(score: _score, wrongAnswers: _wrongAnswers),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[_currentQuestionIndex];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF64C7FF), Color(0xFFE26D8B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, color: Colors.white, size: 28),
                  Text(
                    '$_timeLeft s',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Judul Quiz
            const Text(
              'Quiz',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            // Pertanyaan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                currentQuestion.questionText,
                style: const TextStyle(fontSize: 18, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Pilihan Jawaban
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: List.generate(currentQuestion.answers.length, (index) {
                  bool isSelected = _selectedAnswer == index;
                  Color answerColor = isSelected ? Colors.green.shade200 : Colors.white;

                  return GestureDetector(
                    onTap: () => _selectAnswer(index),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: answerColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: isSelected ? Colors.green : Colors.grey,
                            child: Text(
                              String.fromCharCode(65 + index),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              currentQuestion.answers[index],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 30),

            // Tombol Navigasi (Back & Next)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.5),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if (_currentQuestionIndex > 0) {
                        setState(() {
                          _currentQuestionIndex--;
                          _selectedAnswer = -1;
                          _timeLeft = 30;
                        });
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Back'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _selectedAnswer != -1 ? _nextQuestion : null,
                    child: Text(
                      _currentQuestionIndex == questions.length - 1 ? 'Hasil' : 'Next',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
