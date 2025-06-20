import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progresso'),
        backgroundColor: const Color(0xFF6C63FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Gap(24),
            const Text(
              'Seu Progresso',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(24),
            _progressIndicator('Hábitos concluídos', 0.7),
            const Gap(16),
            _progressIndicator('Meta semanal', 0.5),
            const Gap(16),
            _progressIndicator('Consistência mensal', 0.8),
          ],
        ),
      ),
    );
  }

  Widget _progressIndicator(String label, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const Gap(8),
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey.shade300,
          color: const Color(0xFF6C63FF),
          minHeight: 10,
        ),
      ],
    );
  }
}
