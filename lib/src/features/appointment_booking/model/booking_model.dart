
import 'dart:convert';

BookingModel bookingModelFromJson(String str) => BookingModel.fromJson(json.decode(str));

String bookingModelToJson(BookingModel data) => json.encode(data.toJson());

class BookingModel {
  int? totalPayableAmount;
  String firstName;
  String middleName;
  String lastName;
  String dob;
  String gender;
  String email;
  String mobile;
  String provienceName;
  String districtName;
  String municipalityName;
  String wardNo;
  String tole;
  String bookingType;
  String clinetId;
  String appointmentDate;
  String schemeType;
  String id;


  BookingModel({
    this.totalPayableAmount,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dob,
    required this.gender,
    required this.email,
    required this.mobile,
    required this.provienceName,
    required this.districtName,
    required this.municipalityName,
    required this.wardNo,
    required this.tole,
    required this.bookingType,
    required this.clinetId,
    required this.appointmentDate,
    required this.schemeType,
    required this.id,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    totalPayableAmount: json["total_payable_amount"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    dob: json["dob"],
    gender: json["gender"],
    email: json["email"],
    mobile: json["mobile"],
    provienceName: json["provience_name"],
    districtName: json["district_name"],
    municipalityName: json["municipality_name"],
    wardNo: json["ward_no"],
    tole: json["tole"],
    bookingType: json["booking_type"],
    clinetId: json["clinet_id"],
    appointmentDate: json["appointment_date"],
    schemeType: json["scheme_type"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "total_payable_amount": totalPayableAmount,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "dob": dob,
    "gender": gender,
    "email": email,
    "mobile": mobile,
    "provience_name": provienceName,
    "district_name": districtName,
    "municipality_name": municipalityName,
    "ward_no": wardNo,
    "tole": tole,
    "booking_type": bookingType,
    "clinet_id": clinetId,
    "appointment_date": appointmentDate,
    "scheme_type": schemeType,
    "id": id,
  };
}
