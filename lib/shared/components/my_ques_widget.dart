import 'package:algad_infohub/shared/components/main_widget.dart';
import 'package:algad_infohub/shared/constants/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../modules/questions_screen/cubit/questions_cubit.dart';
import '../../modules/questions_screen/questions_details_screen.dart';
import '../colors.dart';
import 'icon_broken.dart';

class MyQuestionWidget extends StatelessWidget {
  CollectionReference questionRef =
      FirebaseFirestore.instance.collection('myQuestions');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: questionRef
                .orderBy('publishDate', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: mainColor,
                ));
              }
              if (snapshot.hasData) {
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    var date = SharedFunctions.dateFormatter(
                      data['publishDate'],
                    );
                    return MainWidget(
                      id: data['id'],
                      title: data['question'],
                      subTitle: data['answer'],
                      date: date,
                      onPressed: () {Navigator.push(context, MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => QuestionCubit(),
                          child: QuestionsDetailsScreen(
                            id: data['id'],
                            question: data['question'],
                            answer: data['answer'],
                            date: data['publishDate']
                                .toString(),
                          ),
                        ),
                      ),);},
                    );
                  },
                  itemCount: (snapshot.data!).docs.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    color: mainColor,
                    thickness: 1,
                  ),
                );
              }
              return const Text('');
            },
          ),
        ),
      ),
    );
  }
}
