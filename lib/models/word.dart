import 'package:hive/hive.dart';

part 'word.g.dart';

@HiveType(typeId: 0)
class Word extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String word;

  @HiveField(2)
  String translation;

  @HiveField(3)
  String partOfSpeech;

  @HiveField(4)
  int rank;

  @HiveField(5)
  double frequency;

  @HiveField(6)
  String example;

  Word({
    required this.id,
    required this.word,
    required this.translation,
    required this.partOfSpeech,
    required this.rank,
    required this.frequency,
    required this.example
  });
}
