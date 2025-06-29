import 'package:hive/hive.dart';
import '../../models/word.dart';

class MainMenuController {
  static Future<(int total, int learned)> getProgress() async {
    final box = Hive.box<Word>('words');
    final all = box.values.toList();
    final learned = 0;//all.where((w) => w.correctCount >= 5).length;
    return (all.length, learned);
  }
}
