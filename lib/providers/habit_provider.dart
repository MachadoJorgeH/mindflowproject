import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindflow/models/habit_model.dart';
// import '../models/habit.dart';
import '../services/habit_service.dart';

final habitServiceProvider = Provider((ref) => HabitService());

final habitListProvider = StreamProvider<List<Habit>>((ref) {
  return ref.watch(habitServiceProvider).getHabits();
});