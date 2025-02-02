// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class NotificationBody {
  String? topic;
  String? tittle;
  String? body;
  String? sound;
  String? image;
  String? orderId;

  NotificationBody(
      {this.topic,
      this.tittle,
      this.body,
      this.sound,
      this.image,
      this.orderId});

  NotificationBody.fromJson(Map<String, dynamic> json) {
    topic = json['topic'];
    tittle = json['title'];
    body = json['body'];
    sound = json['sound'];
    image = json['image'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topic'] = topic;
    data['title'] = tittle;
    data['body'] = body;
    data['sound'] = sound;
    data['image'] = image;
    data['order_id'] = orderId;
    return data;
  }
}
