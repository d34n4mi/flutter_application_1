class StudySchedule {
  final String subject;
  final String studyTime;
  final String description;

  StudySchedule({
    required this.subject,
    required this.studyTime,
    required this.description,
  });

  // Convert schedule into JSON
  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'studyTime': studyTime,
      'description': description,
    };
  }

  // Convert JSON back into schedule
  factory StudySchedule.fromJson(Map<String, dynamic> json) {
    return StudySchedule(
      subject: json['subject'],
      studyTime: json['studyTime'],
      description: json['description'],
    );
  }
}