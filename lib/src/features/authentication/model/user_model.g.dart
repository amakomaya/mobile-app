// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      name: fields[0] as String?,
      age: fields[1] as int?,
      height: fields[2] as String?,
      districtId: fields[3] as int?,
      municipalityId: fields[4] as int?,
      ward: fields[5] as String?,
      tole: fields[25] as String?,
      phone: fields[6] as dynamic,
      bloodGroup: fields[7] as String?,
      husbandName: fields[8] as String?,
      lmpDateEn: fields[9] as String?,
      lmpDateNp: fields[10] as String?,
      healthpostName: fields[11] as String?,
      hpDistrict: fields[12] as int?,
      hpMunicipality: fields[13] as int?,
      hpWard: fields[14] as int?,
      chronicIllness: fields[15] as String?,
      currentHealthpost: fields[16] as String?,
      noOfPregnantBefore: fields[17] as String?,
      moolDartaNo: fields[18] as String?,
      sewaDartaNo: fields[19] as String?,
      orcDartaNo: fields[20] as String?,
      healthWorkerFullName: fields[21] as String?,
      healthWorkerPost: fields[22] as String?,
      healthWorkerPhone: fields[23] as String?,
      registerAs: fields[24] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.districtId)
      ..writeByte(4)
      ..write(obj.municipalityId)
      ..writeByte(5)
      ..write(obj.ward)
      ..writeByte(25)
      ..write(obj.tole)
      ..writeByte(6)
      ..write(obj.phone)
      ..writeByte(7)
      ..write(obj.bloodGroup)
      ..writeByte(8)
      ..write(obj.husbandName)
      ..writeByte(9)
      ..write(obj.lmpDateEn)
      ..writeByte(10)
      ..write(obj.lmpDateNp)
      ..writeByte(11)
      ..write(obj.healthpostName)
      ..writeByte(12)
      ..write(obj.hpDistrict)
      ..writeByte(13)
      ..write(obj.hpMunicipality)
      ..writeByte(14)
      ..write(obj.hpWard)
      ..writeByte(15)
      ..write(obj.chronicIllness)
      ..writeByte(16)
      ..write(obj.currentHealthpost)
      ..writeByte(17)
      ..write(obj.noOfPregnantBefore)
      ..writeByte(18)
      ..write(obj.moolDartaNo)
      ..writeByte(19)
      ..write(obj.sewaDartaNo)
      ..writeByte(20)
      ..write(obj.orcDartaNo)
      ..writeByte(21)
      ..write(obj.healthWorkerFullName)
      ..writeByte(22)
      ..write(obj.healthWorkerPost)
      ..writeByte(23)
      ..write(obj.healthWorkerPhone)
      ..writeByte(24)
      ..write(obj.registerAs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
