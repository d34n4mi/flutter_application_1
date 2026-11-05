import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static const Color primaryColor = Color(0xFF526DFF);
  static const Color backgroundColor = Color(0xFFF5F7FF);

  static const String storageKey = 'dysion_schedules';

  @override
  void initState() {
    super.initState();
    loadSchedules();
  }

  // Load saved schedules
  Future<void> loadSchedules() async {
    final prefs = await SharedPreferences.getInstance();

    final savedData = prefs.getString(storageKey);

    if (savedData != null) {
      final List<dynamic> decodedData = jsonDecode(savedData);

      final loadedSchedules = decodedData.map((item) {
        return StudySchedule.fromJson(
          Map<String, dynamic>.from(item),
        );
      }).toList();

      if (!mounted) return;

      setState(() {
        schedules.addAll(loadedSchedules);
      });
    }
  }

  // Save schedules
  Future<void> saveSchedules() async {
    final prefs = await SharedPreferences.getInstance();

    final encodedData = jsonEncode(
      schedules.map((schedule) => schedule.toJson()).toList(),
    );

    await prefs.setString(storageKey, encodedData);
  }

  // Add schedule
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

      await saveSchedules();
    }
  }

  // Open details and delete schedule
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

      await saveSchedules();

      if (!mounted) return;

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
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text(
          'Dysion',
          style: TextStyle(
            color: Color(0xFF20294A),
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: Color(0xFFE5EAFE),
              child: Icon(
                Icons.person_outline,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              const Text(
                'Welcome to Dysion!',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF20294A),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Make every study session count.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey,
                ),
              ),

              const SizedBox(height: 24),

              // Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF526DFF),
                      Color(0xFF8294FF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.22),
                      blurRadius: 15,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Study Progress',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${schedules.length} Schedules',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Stay focused and keep learning!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.menu_book_rounded,
                      color: Colors.white,
                      size: 55,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Schedule Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Study Schedule',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF20294A),
                    ),
                  ),
                  Text(
                    '${schedules.length} total',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Schedule List
              Expanded(
                child: schedules.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: const BoxDecoration(
                                color: Color(0xFFE9EDFF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.menu_book_rounded,
                                size: 45,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'No study schedules yet.\n'
                              'Add your first schedule!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.6,
                                color: Colors.blueGrey,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Start organizing your study time.',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: schedules.length,
                        itemBuilder: (context, index) {
                          final schedule = schedules[index];

                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 13,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(
                                    alpha: 0.035,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              leading: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9EDFF),
                                  borderRadius:
                                      BorderRadius.circular(13),
                                ),
                                child: const Icon(
                                  Icons.book_rounded,
                                  color: primaryColor,
                                ),
                              ),
                              title: Text(
                                schedule.subject,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF20294A),
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(
                                  top: 6,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_rounded,
                                      size: 14,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(schedule.studyTime),
                                  ],
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Colors.blueGrey,
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
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: addSchedule,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 5,
        icon: const Icon(Icons.add),
        label: const Text(
          'Add Schedule',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}