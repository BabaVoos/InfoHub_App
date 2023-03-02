import 'package:algad_infohub/modules/questions_screen/questions_details_screen.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return BlocConsumer<InfoHubCubit, InfoHubState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(IconBroken.Arrow___Right_2),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              titleSpacing: 0,
              title: Text(
                'رجوع',
                style: TextStyle(fontSize: 22),
              ),
              backgroundColor: questions,
              elevation: 0,
            ),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .05,
                    vertical: size.height * .02,
                  ),
                  alignment: Alignment.bottomRight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: questions,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: size.height * .07,
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white.withOpacity(.7),
                        ),
                        hintText: 'ابحث',
                      ),
                      autofocus: false,
                      onChanged: (val) {
                        setState(() {
                          question = val;
                          answer = val;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('myQuestions')
                            .snapshots(),
                        builder: (context, snapshots) {
                          return (snapshots.connectionState ==
                                  ConnectionState.waiting)
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: questions,
                                  ),
                                )
                              : ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var data = snapshots.data!.docs[index]
                                        .data() as Map<String, dynamic>;
                                    if (question.isEmpty && answer.isEmpty) {
                                      return Container();
                                    }
                                    if (data['question']
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                question.toLowerCase()) ||
                                        data['answer']
                                            .toString()
                                            .toLowerCase()
                                            .contains(answer.toLowerCase())) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                create: (context) =>
                                                    InfoHubCubit(),
                                                child: QuestionsDetailsScreen(
                                                  question: data['question'],
                                                  answer: data['answer'],
                                                  date: data['date'],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: size.height * .02,
                                            horizontal: size.width * .01,
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  offset: Offset(4, 4),
                                                  blurRadius: 5,
                                                  spreadRadius: 2,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  size.width * .03),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text(
                                                    data['question'],
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * .05,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: questions,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        size.height * .001,
                                                  ),
                                                  Text(
                                                    data['answer'],
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width *
                                                                .05,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        height:
                                                            size.height *
                                                                .0015),
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                      vertical:
                                                          size.height * .01,
                                                      horizontal:
                                                          size.width * .3,
                                                    ),
                                                    child: Divider(
                                                      thickness: 2,
                                                      color: questions,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        IconBroken.Calendar,
                                                        size: size.width *
                                                            .05,
                                                        color: questions,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        data['date'],
                                                        style: TextStyle(
                                                          fontSize:
                                                              size.width *
                                                                  .04,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                          color: questions,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        'إقرأ المزيد',
                                                        style: TextStyle(
                                                          color: questions,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        IconBroken.Arrow___Left_2,
                                                        size: 15,
                                                        color: questions,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
