// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_word_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserWordDataAdapter extends TypeAdapter<UserWordData> {
  @override
  final int typeId = 1;

  @override
  UserWordData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserWordData(
      wordId: fields[0] as int,
      status: fields[1] as WordStatus,
      lastReviewed: fields[2] as DateTime?,
      correctAnswers: fields[3] as int,
      addedAt: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, UserWordData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.wordId)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.lastReviewed)
      ..writeByte(3)
      ..write(obj.correctAnswers)
      ..writeByte(4)
      ..write(obj.addedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserWordDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
