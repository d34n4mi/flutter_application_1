import 'package:flutter/material.dart';
import '../models/study_schedule.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key});

  @override
  State<AddScheduleScreen> createState() =>
      _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final TextEditingController subjectController =
      TextEditingController();

  final TextEditingController timeController =
      TextEditingController();

  final TextEditingController descriptionController =
      TextEditingController();

  final Color primaryColor = const Color(0xFF526DFF);
  final Color backgroundColor = const Color(0xFFF5F7FF);
  final Color navyColor = const Color(0xFF172554);

  @override
  void dispose() {
    subjectController.dispose();
    timeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void saveSchedule() {
    if (subjectController.text.trim().isEmpty ||
        timeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please fill in all required fields!',
          ),
          backgroundColor: navyColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
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

  InputDecoration inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: primaryColor,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.blueGrey.withValues(alpha: 0.12),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: primaryColor,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: navyColor,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Add Schedule',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF526DFF),
                    Color(0xFF8298FF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.edit_calendar_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Plan Your Study',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Create a new schedule and stay productive!',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Form title
            Text(
              'Schedule Details',
              style: TextStyle(
                color: navyColor,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Fill in the information below.',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 22),

            // Subject
            Text(
              'Subject *',
              style: TextStyle(
                color: navyColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 9),

            TextField(
              controller: subjectController,
              decoration: inputDecoration(
                label: 'Subject',
                hint: 'Example: Mathematics',
                icon: Icons.menu_book_rounded,
              ),
            ),

            const SizedBox(height: 20),

            // Study Time
            Text(
              'Study Time *',
              style: TextStyle(
                color: navyColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 9),

            TextField(
              controller: timeController,
              decoration: inputDecoration(
                label: 'Study Time',
                hint: 'Example: 08:00 AM',
                icon: Icons.access_time_rounded,
              ),
            ),

            const SizedBox(height: 20),

            // Description
            Text(
              'Description',
              style: TextStyle(
                color: navyColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 9),

            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: inputDecoration(
                label: 'Description',
                hint: 'Write your study notes here...',
                icon: Icons.notes_rounded,
              ),
            ),

            const SizedBox(height: 30),

            // Save button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: saveSchedule,
                icon: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.white,
                ),
                label: const Text(
                  'Save Schedule',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 3,
                  shadowColor: primaryColor.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}