import 'package:hive/hive.dart';

part 'word_status.g.dart'; // 👈 обязательно для генерации

@HiveType(typeId: 3) // 👈 обязательно
enum WordStatus {
  @HiveField(0)
  newWord,

  @HiveField(1)
  learning,

  @HiveField(2)
  toRepeat,

  @HiveField(3)
  learned,
}
