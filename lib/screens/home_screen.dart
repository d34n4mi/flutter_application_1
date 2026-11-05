
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
  final List<StudySchedule> schedules = [];

  Future<void> addSchedule() async {
    final newSchedule = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddScheduleScreen(),
      ),
    );

    if (!mounted) return;

    if (newSchedule != null && newSchedule is StudySchedule) {
      setState(() {
        schedules.add(newSchedule);
      });
    }
  }

  Future<void> openDetails(int index) async {
    final schedule = schedules[index];

    final shouldDelete = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(schedule: schedule),
      ),
    );

    if (!mounted) return;

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
        title: const Text('Dysion'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Dysion!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your Study Schedule',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: schedules.isEmpty
                  ? const Center(
                      child: Text(
                        'No study schedules yet.\n'
                        'Add your first schedule!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: schedules.length,
                      itemBuilder: (context, index) {
                        final schedule = schedules[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const Icon(Icons.book),
                            title: Text(schedule.subject),
                            subtitle: Text(schedule.studyTime),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () => openDetails(index),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addSchedule,
        child: const Icon(Icons.add),
      ),
    );
  }
}
