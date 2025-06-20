import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  final String id;
  final String name;
  final String description;
  final List<String> frequency;
  final bool isCompleted;
  final Timestamp createdAt;

  Habit({
    required this.id,
    required this.name,
    required this.description,
    required this.frequency,
    required this.isCompleted,
    required this.createdAt,
  });

  factory Habit.fromMap(Map<String, dynamic> data, String documentId) {
    return Habit(
      id: documentId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      frequency: List<String>.from(data['frequency'] ?? []),
      isCompleted: data['isCompleted'] ?? false,
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'frequency': frequency,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
    };
  }
}
