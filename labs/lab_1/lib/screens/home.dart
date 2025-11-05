import 'package:flutter/material.dart';
import 'package:test_starter/screens/exam_details.dart';
import '../models/models.dart';
import '../widgets/exam_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Exam> exams = [
    Exam(
      subjectName: "Математика 1",
      date: DateTime(2024, 7, 10, 9, 0),
      placeForExam: List<String>.from(["Амфитеатар А1"]),
    ),
    Exam(
      subjectName: "Интернет Технологии",
      date: DateTime(2026, 7, 11, 12, 0),
      placeForExam: List<String>.from(["Амфитеатар А2"]),
    ),
    Exam(
      subjectName: "Интегрирани Системи",
      date: DateTime(2025, 12, 12, 9, 0),
      placeForExam: List<String>.from(["Лаб К3"]),
    ),
    Exam(
      subjectName: "Програмирање 1",
      date: DateTime(2024, 12, 13, 10, 0),
      placeForExam: List<String>.from(["Амфитеатар А1"]),
    ),
    Exam(
      subjectName: "Електроника 1",
      date: DateTime(2024, 3, 14, 11, 0),
      placeForExam: List<String>.from(["Лаб К1"]),
    ),
    Exam(
      subjectName: "Физика 1",
      date: DateTime(2025, 12, 15, 9, 0),
      placeForExam: List<String>.from(["Амфитеатар А3"]),
    ),
    Exam(
      subjectName: "Логика и Сетови",
      date: DateTime(2024, 4, 16, 10, 0),
      placeForExam: List<String>.from(["Амфитеатар А2", "Лаб К2"]),
    ),
    Exam(
      subjectName: "Дискретна Математика",
      date: DateTime(2024, 5, 17, 12, 0),
      placeForExam: List<String>.from(["Амфитеатар А1"]),
    ),
    Exam(
      subjectName: "Електромагнетизам",
      date: DateTime(2024, 7, 18, 9, 0),
      placeForExam: List<String>.from(["Амфитеатар А3"]),
    ),
    Exam(
      subjectName: "Програмирање 2",
      date: DateTime(2024, 7, 19, 11, 0),
      placeForExam: List<String>.from(["Лаб К2"]),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    exams.sort((a, b) => b.date.compareTo(a.date));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            for (final exam in exams)
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExamDetailsPage(exam: exam),
                  ),
                ),
                child: ExamCard(exam: exam),
              ),
            Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  "Број на испити:",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    exams.length.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(4),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
