import 'package:hive/hive.dart';

part 'word.g.dart';

@HiveType(typeId: 0)
class Word extends HiveObject {
  @HiveField(0)
  String word;

  @HiveField(1)
  String translation;

  @HiveField(2)
  String partOfSpeech;

  @HiveField(3)
  int rank;

  @HiveField(4)
  double frequency;

  @HiveField(5)
  String example;

  @HiveField(6)
  int correctCount;

  Word({
    required this.word,
    required this.translation,
    required this.partOfSpeech,
    required this.rank,
    required this.frequency,
    required this.example,
    this.correctCount = 0,
  });
}
