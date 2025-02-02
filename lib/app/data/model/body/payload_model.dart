// ignore_for_file: prefer_collection_literals

class PayLoadBody {
  String? topicName;
  String? tittle;
  String? body;
  String? sound;

  PayLoadBody({this.topicName, this.tittle, this.body, this.sound});

  PayLoadBody.fromJson(Map<String, dynamic> json) {
    topicName = json['topicName'];
    tittle = json['title'];
    body = json['body'];
    sound = json['sound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['topicName'] = topicName;
    data['title'] = tittle;
    data['body'] = body;
    data['sound'] = sound;
    return data;
  }
}
