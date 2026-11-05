
import 'package:flutter/material.dart';
import '../models/study_schedule.dart';

class DetailScreen extends StatelessWidget {
  final StudySchedule schedule;

  const DetailScreen({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Details'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject
            Text(
              schedule.subject,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Study Time
            Text(
              'Study Time: ${schedule.studyTime}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 15),

            // Description
            Text(
              'Description: ${schedule.description.isEmpty ? "No description" : schedule.description}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            // Delete Schedule Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Delete Schedule'),
            ),
          ],
        ),
      ),
    );
  }
}
