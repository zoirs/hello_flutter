import 'package:hello_flutter/models/word_status.dart';
import 'package:hive/hive.dart';
import '../models/word.dart';
import '../models/user_word_data.dart';

class UserProgressService {
  final Box<UserWordData> userWordBox;

  UserProgressService(this.userWordBox);

  /// Добавляет слово в прогресс, если его там ещё нет
  Future<bool> addWordToProgress(int wordId) async {
    final exists = userWordBox.values.any((data) => data.wordId == wordId);

    if (exists) {
      return false; // Уже есть
    }

    final newUserData = UserWordData(wordId: wordId);
    await userWordBox.put(wordId, newUserData);
    return true; // Успешно добавлено
  }

  /// Получает прогресс по слову
  UserWordData? getUserProgress(int wordId) {
    if (!userWordBox.containsKey(wordId)) {
      addWordToProgress(wordId);
    }
    return userWordBox.get(wordId);
  }

  /// Обновляет статус слова
  Future<void> updateStatus(int wordId, WordStatus newStatus) async {
    final data = userWordBox.get(wordId);
    if (data != null) {
      data.status = newStatus;
      await data.save();
    }
  }
  
  Future<void> incAnswer(int wordId) async {
    final data = userWordBox.get(wordId);
    if (data != null) {
      data.correctAnswers++;
      await data.save();
    }
  }
}
