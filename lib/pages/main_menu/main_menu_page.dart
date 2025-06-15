import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/word.dart';
import 'main_menu_controller.dart';
import 'menu_button.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  int totalWords = 0;
  int learnedWords = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final (total, learned) = await MainMenuController.getProgress();
    setState(() {
      totalWords = total;
      learnedWords = learned;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Text('Английские слова', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Тренируйся, запоминай, учи.', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              SizedBox(height: 24),
              if (totalWords > 0)
                Column(
                  children: [
                    Text('Выучено: $learnedWords из $totalWords', style: TextStyle(fontSize: 16, color: Colors.black54)),
                    SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: learnedWords / totalWords,
                      minHeight: 8,
                      backgroundColor: Colors.grey[200],
                      color: Colors.blue,
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              Spacer(),
              MenuButton(label: '🚀 Начать', onTap: () => Navigator.pushNamed(context, '/learn')),
              MenuButton(label: '⚙️ Настройки', onTap: () => Navigator.pushNamed(context, '/settings')),
              MenuButton(label: '🚪 Выход', onTap: () {
                // SystemNavigator.pop();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
