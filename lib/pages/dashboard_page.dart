import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindflow/models/habit_model.dart';
import 'package:mindflow/pages/add_habit_page.dart';
// import 'package:mindflow/models/habit.dart';
import '../providers/habit_provider.dart';
import '../services/habit_service.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitListAsync = ref.watch(habitListProvider);
    final habitService = ref.watch(habitServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seus Hábitos'),
        backgroundColor: const Color(0xFF6C63FF),
      ),
      body: habitListAsync.when(
        data: (habits) {
          if (habits.isEmpty) {
            return const Center(child: Text('Nenhum hábito cadastrado.'));
          }
          return ListView.builder(
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              return Card(
                elevation: 3, // Define a elevação do card
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ), // Margem entre os cards
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    16,
                  ), // Bordas arredondadas
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ), // Espaçamento interno do card
                  child: Row(
                    children: [
                      Checkbox(
                        value: habit.isCompleted,
                        onChanged: (value) {
                          habitService.updateHabit(
                            Habit(
                              id: habit.id,
                              name: habit.name,
                              description: habit.description,
                              frequency: habit.frequency,
                              isCompleted: value ?? false,
                              createdAt: habit.createdAt,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 12,
                      ), // Espaçamento entre o checkbox e o texto
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              habit.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                decoration: habit.isCompleted
                                    ? TextDecoration
                                          .lineThrough // Adiciona o risco se concluído
                                    : TextDecoration
                                          .none, // Remove o risco se não concluído
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ), // Espaçamento entre o título e a descrição
                            Text(
                              habit.description,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                decoration: habit.isCompleted
                                    ? TextDecoration
                                          .lineThrough // Adiciona o risco se concluído
                                    : TextDecoration
                                          .none, // Remove o risco se não concluído
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          habitService.deleteHabit(habit.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.deepPurple),
        ),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6C63FF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddHabitPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
