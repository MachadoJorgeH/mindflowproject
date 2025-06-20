// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mindflow/providers/habit_provider.dart';
// import '../models/habit_model.dart';
// import '../providers/auth_provider.dart';

// class AddHabitDialog extends ConsumerStatefulWidget {
//   const AddHabitDialog({super.key});

//   @override
//   ConsumerState<AddHabitDialog> createState() => _AddHabitDialogState();
// }

// class _AddHabitDialogState extends ConsumerState<AddHabitDialog> {
//   final titleController = TextEditingController();
//   final descriptionController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final user = ref.watch(authStateProvider).value;
//     final habitService = ref.read(habitServiceProvider);

//     return AlertDialog(
//       title: Center(child: const Text('Novo Hábito')),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: titleController,
//             decoration: const InputDecoration(labelText: 'Título'),
//           ),
//           TextField(
//             controller: descriptionController,
//             decoration: const InputDecoration(labelText: 'Descrição'),
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Cancelar'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (user != null) {
//               final habit = Habit(
//                 id: '',
//                 title: titleController.text,
//                 description: descriptionController.text,
//                 createdAt: DateTime.now(),
//                 isDone: false,
//                 userId: user.uid,
//               );
//               habitService.addHabit(habit);
//               Navigator.pop(context);
//             }
//           },
//           child: const Text('Registrar'),
//         ),
//       ],
//     );
//   }
// }
