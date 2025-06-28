import 'package:hello_flutter/models/WordStatus.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class UserWordData extends HiveObject {
  @HiveField(0)
  final String wordId;

  @HiveField(1)
  WordStatus status;

  @HiveField(2)
  DateTime? lastReviewed;

  @HiveField(3)
  int correctAnswers;

  @HiveField(4)
  DateTime addedAt;

  UserWordData({
    required this.wordId,
    this.status = WordStatus.newWord,
    this.lastReviewed,
    this.correctAnswers = 0,
    DateTime? addedAt,
  }) : addedAt = addedAt ?? DateTime.now();
}