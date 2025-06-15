import 'dart:math';
import 'package:hive/hive.dart';
import '../models/word.dart';

class WordService {
  static final _random = Random();

  /// Возвращает кортеж: (основное слово, варианты ответов)
  static Future<(Word, List<String>)> getRandomWordWithOptions() async {
    final box = Hive.box<Word>('words');
    final words = box.values.toList();

    if (words.length < 4) {
      throw Exception('Недостаточно слов для генерации вариантов');
    }

    final mainWord = words[_random.nextInt(words.length)];

    // Берём 3 других перевода (не равных правильному)
    final wrongOptions =
        words.where((w) => w.word != mainWord.word).toList()..shuffle();

    final options = [
      mainWord.translation,
      ...wrongOptions.take(3).map((w) => w.translation),
    ]..shuffle();

    return (mainWord, options);
  }

  static Future<void> deleteWord(Word word) async {
    final box = Hive.box<Word>('words');
    await box.delete(word.key);
  }
}
