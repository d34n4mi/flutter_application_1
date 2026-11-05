
import 'package:flutter/material.dart';
import '../models/study_schedule.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key});

  @override
  State<AddScheduleScreen> createState() =>
      _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  // TextEditingController
  final TextEditingController subjectController =
      TextEditingController();

  final TextEditingController timeController =
      TextEditingController();

  final TextEditingController descriptionController =
      TextEditingController();

  // Dispose controllers
  @override
  void dispose() {
    subjectController.dispose();
    timeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // Save schedule with input validation
  void saveSchedule() {
    if (subjectController.text.trim().isEmpty ||
        timeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill in all required fields!',
          ),
        ),
      );
    } else {
      final newSchedule = StudySchedule(
        subject: subjectController.text.trim(),
        studyTime: timeController.text.trim(),
        description: descriptionController.text.trim(),
      );

      Navigator.pop(context, newSchedule);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Schedule'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // Subject input
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // Study time input
            TextField(
              controller: timeController,
              decoration: const InputDecoration(
                labelText: 'Study Time',
                hintText: 'Example: 08:00 AM',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // Description input
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Save button
            ElevatedButton(
              onPressed: saveSchedule,
              child: const Text('Save Schedule'),
            ),
          ],
        ),
      ),
    );
  }
}
