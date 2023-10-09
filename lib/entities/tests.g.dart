// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tests.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TestAdapter extends TypeAdapter<Test> {
  @override
  final int typeId = 3;

  @override
  Test read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Test(
      result: fields[4] as String?,
      id: fields[0] as String,
      name: fields[1] as String,
      image: fields[2] as String,
      text: fields[3] as String,
      questionsCount: fields[5] as int,
    )..questions = (fields[6] as HiveList?)?.castHiveList();
  }

  @override
  void write(BinaryWriter writer, Test obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.text)
      ..writeByte(4)
      ..write(obj.result)
      ..writeByte(5)
      ..write(obj.questionsCount)
      ..writeByte(6)
      ..write(obj.questions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TestQuestionAdapter extends TypeAdapter<TestQuestion> {
  @override
  final int typeId = 4;

  @override
  TestQuestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TestQuestion(
      id: fields[0] as String,
      image: fields[1] as String?,
      text: fields[2] as String,
    )..answers = (fields[4] as HiveList?)?.castHiveList();
  }

  @override
  void write(BinaryWriter writer, TestQuestion obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(4)
      ..write(obj.answers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestQuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TestAnswerAdapter extends TypeAdapter<TestAnswer> {
  @override
  final int typeId = 5;

  @override
  TestAnswer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TestAnswer(
      id: fields[0] as String,
      text: fields[1] as String,
      isRight: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TestAnswer obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.isRight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestAnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
