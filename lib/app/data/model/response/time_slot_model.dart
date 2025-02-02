import 'dart:convert';

TimeSlotModel timeSlotModelFromJson(String str) =>
    TimeSlotModel.fromJson(json.decode(str));

String timeSlotModelToJson(TimeSlotModel data) => json.encode(data.toJson());

class TimeSlotModel {
  TimeSlotModel({
    this.data,
  });

  List<TimeSlotData>? data;

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => TimeSlotModel(
        data: json["data"] == null
            ? []
            : List<TimeSlotData>.from(
                json["data"]!.map((x) => TimeSlotData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TimeSlotData {
  TimeSlotData({this.label, this.fromTime, this.toTime, this.time});

  String? label;
  String? fromTime;
  String? toTime;
  String? time;

  factory TimeSlotData.fromJson(Map<String, dynamic> json) => TimeSlotData(
        label: json["label"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "from_time": fromTime,
        "to_time": toTime,
        "time": time,
      };
}
