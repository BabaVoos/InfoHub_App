import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class SharedFunctions {
  static String dateFormatter(Timestamp date) {
    String formattedDate = DateFormat('Md').format(date.toDate()).toString();
    return formattedDate;
  }

  static Future<void> sendNotification({title, body, userId}) async {
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "key=AAAA_saLhaU:APA91bGYueRg36sV8COhMLSkhh_sq-wTNLFplMPctM-xXkE4wiNtnWQJgLCCwfzcq8_bu7n-HGrxapeDY40wEuWNGpt51J7v6wps_Kg58bqbrR9k_c7IffbJqXBe5x8YIMy16tEWmgkQ",
        },
        body: jsonEncode(
          {
            "to": "/topics/notify",
            "priority": "high",
            "notification": {
              "title": "$title",
              "body": "$body",
              "subtitle": "",
            }
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
