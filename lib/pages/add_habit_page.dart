import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindflow/models/habit_model.dart';
import 'package:mindflow/providers/habit_provider.dart';

class AddHabitPage extends ConsumerStatefulWidget {
  const AddHabitPage({super.key});

  @override
  ConsumerState<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends ConsumerState<AddHabitPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    final habitService = ref.watch(habitServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Hábito'),
        backgroundColor: const Color(0xFF6C63FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome do hábito',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                final newHabit = Habit(
                  id: '',
                  name: _nameController.text,
                  description: _descriptionController.text,
                  frequency: [],
                  isCompleted: false,
                  createdAt: Timestamp.now(),
                );
                habitService.addHabit(newHabit);
                Navigator.pop(context);
              },
              child: const Text('Adicionar Hábito'),
            ),
          ],
        ),
      ),
    );
  }
}
