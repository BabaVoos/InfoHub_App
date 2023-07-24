import 'package:cloud_firestore/cloud_firestore.dart';

class Addresses {
  String id;
  String addresses;
  String organizationName;
  Timestamp publishDate;

  Addresses({
    required this.id,
    required this.addresses,
    required this.organizationName,
    required this.publishDate,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) {
    return Addresses(
      id: json["id"],
      addresses: json["addresses"],
      organizationName: json["organizationName"],
      publishDate: json["publishDate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "addresses": addresses,
      "organizationName": organizationName,
      "publishDate": publishDate,
    };
  }
}
