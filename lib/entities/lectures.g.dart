// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lectures.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LectureAdapter extends TypeAdapter<Lecture> {
  @override
  final int typeId = 2;

  @override
  Lecture read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lecture(
      image: fields[2] as String?,
      videoUrl: fields[6] as String?,
      links: (fields[7] as List?)?.cast<String>(),
      id: fields[0] as String,
      name: fields[1] as String,
      text: fields[3] as String,
      currentPage: fields[4] as int,
      isFinished: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Lecture obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.text)
      ..writeByte(4)
      ..write(obj.currentPage)
      ..writeByte(5)
      ..write(obj.isFinished)
      ..writeByte(6)
      ..write(obj.videoUrl)
      ..writeByte(7)
      ..write(obj.links);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LectureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
