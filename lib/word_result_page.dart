import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models/word.dart';

class WordResultPage extends StatelessWidget {
  final Word word;
  final bool isCorrect;
  final int progress;

  const WordResultPage({
    super.key,
    required this.word,
    required this.isCorrect,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCorrect ? Colors.green : Colors.red;
    final icon = isCorrect ? Icons.check_circle_outline : Icons.highlight_off;
    final message = isCorrect ? 'Верно!' : 'Неверно';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 80, color: color),
              SizedBox(height: 16),
              Text(
                message,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '${word.word} — ${word.translation}',
                style: TextStyle(fontSize: 22, color: Colors.black87),
              ),
              SizedBox(height: 16),
              Text(
                'Прогресс: ${progress}/5',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),

              SizedBox(height: 40),
              Divider(),
              SizedBox(height: 16),
              Text(
                'Что вы хотите сделать дальше?',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 24),
              _buildActionButton(
                context: context,
                label: '➡ Далее',
                onTap: () {
                  Navigator.pop(context, 'next');
                },
              ),
              _buildActionButton(
                context: context,
                label: 'Скрыть слово',
                onTap: () {
                  Hive.box<Word>('words').delete(word.key);
                  Navigator.pop(context, 'next');
                },
              ),
              _buildActionButton(
                context: context,
                label: 'Сбросить прогресс',
                onTap: () async {
                  // word.correctCount = 0;
                  await word.save(); 
                  Navigator.pop(context, 'next');
                },
              ),

              _buildActionButton(
                context: context,
                label: 'Завершить',
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 52),
          backgroundColor: Colors.grey[200],
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(fontSize: 16),
        ),
        child: Text(label),
      ),
    );
  }
}
