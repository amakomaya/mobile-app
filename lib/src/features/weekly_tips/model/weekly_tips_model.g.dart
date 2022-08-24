// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_tips_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeeklyTipsAdapter extends TypeAdapter<WeeklyTips> {
  @override
  final int typeId = 0;

  @override
  WeeklyTips read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeeklyTips(
      id: fields[0] as int,
      titleEn: fields[1] as String,
      titleNp: fields[2] as String,
      descriptionEn: fields[3] as String,
      descriptionNp: fields[4] as String,
      weekId: fields[5] as int,
      createdAt: fields[6] as DateTime,
      updatedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WeeklyTips obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titleEn)
      ..writeByte(2)
      ..write(obj.titleNp)
      ..writeByte(3)
      ..write(obj.descriptionEn)
      ..writeByte(4)
      ..write(obj.descriptionNp)
      ..writeByte(5)
      ..write(obj.weekId)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyTipsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
