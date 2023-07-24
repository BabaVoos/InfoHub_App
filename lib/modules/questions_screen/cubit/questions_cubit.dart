import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../Authintication/helpers/my_easyloading.dart';
import '../../../models/questions.dart';
import '../../../shared/constants/const.dart';
import 'questions_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionCubit extends Cubit<QuestionStates> {
  QuestionCubit()
      : super(
          QuestionInitialState(),
        );

  static QuestionCubit get(context) => BlocProvider.of(
        context,
      );


  // questionCreate
  void questionCreate({
    required String question,
    required String answer,
  }) async {
    final docUid = FirebaseFirestore.instance
        .collection(
          "myQuestions",
        )
        .doc();

    Question model = Question(
      id: docUid.id,
      question: question,
      answer: answer,
      publishDate: Timestamp.now(),
    );

    await docUid.set(model.toJson()).then((value) {
      SharedFunctions.sendNotification(
        title: model.question,
        body: model.answer,
      );
      emit(
        AddQuestionsSuccessState(),
      );
    }).catchError((error) {
      emit(
        AddQuestionsErrorState(
          error.toString(),
        ),
      );
    });
  }

  void questionsDelete({
    required String id,
  }) {
    FirebaseFirestore.instance
        .collection('myQuestions')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteQuestionsSuccessState());
    }).catchError((error) {
      emit(
        DeleteQuestionsErrorState(
          error.toString(),
        ),
      );
    });
  }

  void questionUpdate({
    required String id,
    required String question,
    required String answer,
    context,
  }) {
    FirebaseFirestore.instance.collection('myQuestions').doc(id).update(
      {
        'question': question,
        'answer': answer,
      },
    ).then((value) {
      showSuccessMessage('Updated Successfully',);
      Navigator.pop(context);
      emit(
        UpdateQuestionSuccessState(),
      );
    }).catchError((error) {
      emit(
        UpdateQuestionErrorState(
          error.toString(),
        ),
      );
    });
  }
}
