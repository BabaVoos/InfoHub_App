import 'package:algad_infohub/modules/news_screen/news_screen_two.dart';
import 'package:algad_infohub/modules/questions_screen/questions_details_screen.dart';
import 'package:algad_infohub/modules/questions_screen/questions_screen_2.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/conponents.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  CollectionReference questionRef =
      FirebaseFirestore.instance.collection('myQuestions');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => InfoHubCubit(),
      child: BlocConsumer<InfoHubCubit, InfoHubState>(
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
                actions: [
                  IconButton(
                    onPressed: () {
                      navigateTo(
                        context,
                        BlocProvider(
                          create: (context) => InfoHubCubit(),
                          child: QuestionsScreenTwo(),
                        ),
                      );
                    },
                    icon: Icon(IconBroken.Search),
                  ),
                ],
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
                    child: Text(
                      'اسئلة متكررة !',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * .08,
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
                        child: StreamBuilder(
                          stream: questionRef.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: questions,
                              ));
                            }
                            if (snapshot.hasData) {
                              return ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) =>
                                                InfoHubCubit(),
                                            child: QuestionsDetailsScreen(
                                              question: ((snapshot.data!
                                                      as QuerySnapshot)
                                                  .docs[index]
                                                  .data() as Map)['question'],
                                              answer: ((snapshot.data!
                                                      as QuerySnapshot)
                                                  .docs[index]
                                                  .data() as Map)['answer'],
                                              date: ((snapshot.data!
                                                      as QuerySnapshot)
                                                  .docs[index]
                                                  .data() as Map)['date'],
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
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (snapshot.data as QuerySnapshot)
                                                    .docs[index]
                                                    .reference
                                                    .id,
                                              ),
                                              Text(
                                                ((snapshot.data!
                                                            as QuerySnapshot)
                                                        .docs[index]
                                                        .data()
                                                    as Map)['question'],
                                                style: TextStyle(
                                                  fontSize:
                                                      size.width * .05,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                  height: 1.3,
                                                  color: questions,
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * .01,
                                              ),
                                              Text(
                                                ((snapshot.data!
                                                            as QuerySnapshot)
                                                        .docs[index]
                                                        .data()
                                                    as Map)['answer'],
                                                style: TextStyle(
                                                    fontSize:
                                                        size.width * .05,
                                                    fontWeight:
                                                        FontWeight.w300,
                                                    height: size.height *
                                                        .0015),
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.symmetric(
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
                                                    size: size.width * .05,
                                                    color: questions,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    ((snapshot.data!
                                                            as QuerySnapshot)
                                                        .docs[index]
                                                        .data() as Map)['date'],
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * .04,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: questions,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    'إقرأ المزيد',
                                                    style: TextStyle(
                                                      color: questions,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                },
                                itemCount: (snapshot.data! as QuerySnapshot)
                                    .docs
                                    .length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(
                                  color: questions,
                                  thickness: 2,
                                ),
                              );
                            }
                            return Text('');
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
      ),
    );
  }
}
