import 'package:flutter/material.dart';
import '../models/models.dart';

class ExamDetailsPage extends StatelessWidget {
  final Exam exam;

  const ExamDetailsPage({super.key, required this.exam});

  String _formatRemainingTime() {
    final DateTime now = DateTime.now();
    final DateTime examDateTime = exam.date;

    final Duration difference = examDateTime.difference(now);

    if (difference.isNegative) {
      return "Испитот поминал";
    }

    final int days = difference.inDays;
    final int hours = difference.inHours.remainder(24);

    return "$days дена, $hours часа";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exam.subjectName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4.0,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Преостанува:",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _formatRemainingTime(),
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Детали за испитот",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(),
            
            ListTile(
              leading: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor),
              title: Text("Датум"),
              subtitle: Text('${exam.date.day.toString().padLeft(2, '0')}.${exam.date.month.toString().padLeft(2, '0')}.${exam.date.year}'),
            ),
            ListTile(
              leading: Icon(Icons.access_time, color: Theme.of(context).primaryColor),
              title: Text("Време"),
              subtitle: Text('${exam.date.hour.toString().padLeft(2, '0')}:${exam.date.minute.toString().padLeft(2, '0')}'),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Theme.of(context).primaryColor),
              title: Text("Местa на одржување"),
              subtitle: Text(exam.placeForExam.join(", ")),
            ),
          ],
        ),
      ),
    );
  }
}