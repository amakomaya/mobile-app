import 'package:equatable/equatable.dart';

class RegisterRequestModel {
  String? name;
  int? age;
  int? isFirstTimeParent;
  String? registerAs;
  String? lmpDateEn;
  String? lmpDateNp;
  String? phone;
  String? email;
  int? districtId;
  int? municipalityId;
  String? tole;
  String? username;
  String? password;
  String? longitude;
  String? latitude;
  String? createdAt;
  String? updatedAt;
  String? dobChild;

  RegisterRequestModel(
      {this.name,
      this.age,
      this.isFirstTimeParent,
      this.registerAs,
      this.lmpDateEn,
      this.lmpDateNp,
      this.phone,
      this.email,
      this.districtId,
      this.municipalityId,
      this.tole,
      this.username,
      this.password,
      this.longitude,
      this.latitude,
      this.createdAt,
      this.dobChild,
      this.updatedAt});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    
    name = json['name'];
    age = json['age'];
    isFirstTimeParent = json['is_first_time_parent'];
    registerAs = json['register_as'];
    lmpDateEn = json['lmp_date_en'];
    lmpDateNp = json['lmp_date_np'];
    phone = json['phone'];
    email = json['email'];
    districtId = json['district_id'];
    municipalityId = json['municipality_id'];
    tole = json['tole'];
    username = json['username'];
    password = json['password'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dobChild = json['dobChild'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['age'] = age;
    data['is_first_time_parent'] = isFirstTimeParent;
    data['register_as'] = registerAs;
    data['lmp_date_en'] = lmpDateEn;
    data['lmp_date_np'] = lmpDateNp;
    data['phone'] = phone;
    data['email'] = email;
    data['district_id'] = districtId;
    data['municipality_id'] = municipalityId;
    data['tole'] = tole;
    data['username'] = username;
    data['password'] = password;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['dobChild'] = dobChild;
    return data;
  }

  RegisterRequestModel copyWith(
          {String? tole,
          int? municipalityId,
          String? name,
          int? age,
          int? isFirstTimeParent,
          String? registerAs,
          String? lmpDateEn,
          String? lmpDateNp,
          String? phone,
          String? email,
          int? districtId,
          String? username,
          String? password,
          String? longitude,
          String? latitude,
          String? dobChild,
          String? createdAt,
          String? updatedAt}) =>
      RegisterRequestModel(
          municipalityId: municipalityId,
          tole: tole,
          age: age,
          latitude: latitude,
          lmpDateEn: lmpDateEn,
          lmpDateNp: lmpDateNp,
          longitude: longitude,
          name: name,
          password: password,
          phone: phone,
          registerAs: registerAs,
          dobChild: dobChild,
          updatedAt: updatedAt,
          username: username,
          createdAt: createdAt,
          districtId: districtId,
          email: email,
          isFirstTimeParent: isFirstTimeParent);
}
