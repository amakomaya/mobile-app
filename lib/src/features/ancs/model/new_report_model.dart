
import 'dart:convert';

NewReportModel newReportModelFromJson(String str) => NewReportModel.fromJson(json.decode(str));

String newReportModelToJson(NewReportModel data) => json.encode(data.toJson());

class NewReportModel {
  int status;
  String message;
  List<Datum> data;

  NewReportModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory NewReportModel.fromJson(Map<String, dynamic> json) => NewReportModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String reportLabel;
  List<ReportDatum> reportData;

  Datum({
    required this.reportLabel,
    required this.reportData,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    reportLabel: json["report_label"],
    reportData: List<ReportDatum>.from(json["report_data"].map((x) => ReportDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "report_label": reportLabel,
    "report_data": List<dynamic>.from(reportData.map((x) => x.toJson())),
  };
}

class ReportDatum {
  String label;
  dynamic value;

  ReportDatum({
    required this.label,
    required this.value,
  });

  factory ReportDatum.fromJson(Map<String, dynamic> json) => ReportDatum(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}
