import 'package:hive/hive.dart';

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