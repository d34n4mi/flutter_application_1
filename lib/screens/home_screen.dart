
import 'package:flutter/material.dart';
import '../models/study_schedule.dart';
import 'add_schedule_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List to store study schedules
  final List<StudySchedule> schedules = [];

  // Navigate to Add Schedule Screen
  Future<void> addSchedule() async {
    final newSchedule = await Navigator.push<StudySchedule>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddScheduleScreen(),
      ),
    );

    if (newSchedule != null) {
      setState(() {
        schedules.add(newSchedule);
      });
    }
  }

  // Navigate to Detail Screen
  Future<void> openDetails(int index) async {
    final shouldDelete = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          schedule: schedules[index],
        ),
      ),
    );

    if (shouldDelete == true) {
      setState(() {
        schedules.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Schedule deleted successfully!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dysion',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Welcome to Dysion!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Text(
            'Your Study Schedule',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: schedules.isEmpty
                ? const Center(
                    child: Text(
                      'No study schedules yet.\nAdd your first schedule!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: schedules.length,
                    itemBuilder: (context, index) {
                      final schedule = schedules[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.menu_book,
                            color: Colors.blue,
                          ),

                          title: Text(
                            schedule.subject,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          subtitle: Text(
                            schedule.studyTime,
                          ),

                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),

                          onTap: () {
                            openDetails(index);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addSchedule,
        child: const Icon(Icons.add),
      ),
    );
  }
}
