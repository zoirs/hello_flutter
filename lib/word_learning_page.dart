import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hello_flutter/services/user_progress_service.dart';
import '../models/word.dart';
import '../services/word_service.dart';
import 'word_result_page.dart';

class WordLearningPage extends StatefulWidget {
  @override
  State<WordLearningPage> createState() => _WordLearningPageState();
}

class _WordLearningPageState extends State<WordLearningPage> {
  Word? currentWord;
  List<String> options = [];

  @override
  void initState() {
    super.initState();
    loadNextWord();
  }

  Future<void> loadNextWord() async {
    final (word, opts) = await WordService.getRandomWordWithOptions();
    setState(() {
      currentWord = word;
      options = opts;
    });
  }

  void checkAnswer(String selected) async {
    final isCorrect = selected == currentWord!.translation;
    UserProgressService userProgressService = GetIt.instance<UserProgressService>();

    if (isCorrect) {
      userProgressService.incAnswer(currentWord!.id);
      // currentWord!.correctCount++;
      // await currentWord!.save();
    }
    final answer = userProgressService.getUserProgress(currentWord!.id)!.correctAnswers;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WordResultPage(word: currentWord!, isCorrect: isCorrect, progress: answer),
      ),
    );

    if (result == 'next') {
      loadNextWord();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentWord == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Что значит:',
                style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              ),
              SizedBox(height: 12),
              Text(
                currentWord!.word,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(
                currentWord!.example,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: Text('(Здесь будет картинка)', style: TextStyle(color: Colors.grey))),
              ),
              SizedBox(height: 32),
              ...options.map((option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(option),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text(option),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
