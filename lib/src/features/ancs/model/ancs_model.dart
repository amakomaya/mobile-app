// To parse this JSON data, do
//
//     final ancModel = ancModelFromJson(jsonString);

import 'dart:convert';

AncModel ancModelFromJson(String str) => AncModel.fromJson(json.decode(str));

String ancModelToJson(AncModel data) => json.encode(data.toJson());

class AncModel {
    AncModel({
        this.token,
        this.womanToken,
        this.weight,
        this.anemia,
        this.swelling,
        this.bloodPressure,
        this.uterusHeight,
        this.babyPresentation,
        this.babyHeartBeat,
        this.other,
        this.visitDate,
        this.checkedBy,
        this.nextVisitDate,
        this.situation,
    });

    String? token;
    String? womanToken;
    String? weight;
    String? anemia;
    String? swelling;
    String? bloodPressure;
    String? uterusHeight;
    String? babyPresentation;
    String? babyHeartBeat;
    String? other;
    DateTime? visitDate;
    String? checkedBy;
    String? nextVisitDate;
    String? situation;

    factory AncModel.fromJson(Map<String, dynamic> json) => AncModel(
        token: json["token"],
        womanToken: json["woman_token"],
        weight: json["weight"],
        anemia: json["anemia"],
        swelling: json["swelling"],
        bloodPressure: json["blood_pressure"],
        uterusHeight: json["uterus_height"],
        babyPresentation: json["baby_presentation"],
        babyHeartBeat: json["baby_heart_beat"],
        other: json["other"],
        visitDate: DateTime.parse(json["visit_date"]),
        checkedBy: json["checked_by"],
        nextVisitDate: json["next_visit_date"],
        situation: json["situation"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "woman_token": womanToken,
        "weight": weight,
        "anemia": anemia,
        "swelling": swelling,
        "blood_pressure": bloodPressure,
        "uterus_height": uterusHeight,
        "baby_presentation": babyPresentation,
        "baby_heart_beat": babyHeartBeat,
        "other": other,
        "visit_date": "${visitDate?.year.toString().padLeft(4, '0')}-${visitDate?.month.toString().padLeft(2, '0')}-${visitDate?.day.toString().padLeft(2, '0')}",
        "checked_by": checkedBy,
        "next_visit_date": nextVisitDate,
        "situation": situation,
    };
}
