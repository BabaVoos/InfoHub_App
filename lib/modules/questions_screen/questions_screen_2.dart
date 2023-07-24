import 'package:algad_infohub/modules/questions_screen/cubit/questions_cubit.dart';
import 'package:algad_infohub/modules/questions_screen/questions_details_screen.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:algad_infohub/shared/components/main_widget.dart';
import 'package:algad_infohub/shared/components/my_app_bar.dart';
import 'package:algad_infohub/shared/components/search_widget.dart';
import 'package:algad_infohub/shared/constants/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

class QuestionsScreenTwo extends StatefulWidget {
  const QuestionsScreenTwo({Key? key}) : super(key: key);

  @override
  State<QuestionsScreenTwo> createState() => _QuestionsScreenTwoState();
}

class _QuestionsScreenTwoState extends State<QuestionsScreenTwo> {
  String question = '';
  String answer = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(
          context,
        ),
        body: Column(
          children: [
            SearchWidget(
              onChanged: (val) {
                setState(() {
                  question = val;
                  answer = val;
                });
              },
            ),
            buildMainWidget(
              size,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMainWidget(size) => Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('myQuestions')
                  .orderBy('publishDate', descending: true)
                  .snapshots(),
              builder: (context, snapshots) {
                return (snapshots.connectionState == ConnectionState.waiting)
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: mainColor,
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = snapshots.data!.docs[index];
                          var date = SharedFunctions.dateFormatter(
                            data['publishDate'],
                          );

                          if (question.isEmpty && answer.isEmpty) {
                            return Container();
                          }
                          if (data['question']
                                  .toString()
                                  .toLowerCase()
                                  .contains(question.toLowerCase()) ||
                              data['answer']
                                  .toString()
                                  .toLowerCase()
                                  .contains(answer.toLowerCase())) {
                            return Column(
                              children: [
                                MainWidget(
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
                                        date: date,
                                      ),
                                    ),
                                  ),);},
                                ),
                                Divider(color: mainColor,thickness: 1,),
                              ],
                            );
                          }
                          return Container();
                        },
                        itemCount: snapshots.data!.docs.length,
                      );
              },
            ),
          ),
        ),
      );
}
