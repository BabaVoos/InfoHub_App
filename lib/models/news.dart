import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String id;
  String organizationName;
  String news;
  Timestamp publishDate;
  bool read;

  News({
    required this.read,
    required this.id,
    required this.organizationName,
    required this.news,
    required this.publishDate,
  });


  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json["id"],
      organizationName: json["organizationName"],
      news: json["news"],
      publishDate: (json["publishDate"]),
      read: json["read"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "organizationName": organizationName,
      "news": news,
      "publishDate": publishDate,
      "read": read,
    };
  }
}
