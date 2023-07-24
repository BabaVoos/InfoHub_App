import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String id;
  String question;
  String answer;
  Timestamp publishDate;

  Question({
    required this.id,
    required this.question,
    required this.answer,
    required this.publishDate,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json["id"],
      question: json["question"],
      answer: json["answer"],
      publishDate: json["publishDate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "question": question,
      "answer": answer,
      "publishDate": publishDate,
    };
  }
}
