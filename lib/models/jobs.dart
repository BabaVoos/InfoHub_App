import 'package:cloud_firestore/cloud_firestore.dart';

class Jobs {
  String id;
  String organizationName;
  String job;
  Timestamp publishDate;

  Jobs({
    required this.id,
    required this.organizationName,
    required this.job,
    required this.publishDate,
  });

  factory Jobs.fromJson(Map<String, dynamic> json) {
    return Jobs(
      id: json["id"],
      organizationName: json["organizationName"],
      job: json["jobs"],
      publishDate: json["publishDate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "organizationName": organizationName,
      "job": job,
      "publishDate": publishDate,
    };
  }
}
