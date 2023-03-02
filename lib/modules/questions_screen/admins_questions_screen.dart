import 'package:algad_infohub/modules/questions_screen/questions_details_screen.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminsQuestionsScreen extends StatefulWidget {
  const AdminsQuestionsScreen({Key? key}) : super(key: key);

  @override
  State<AdminsQuestionsScreen> createState() => _AdminsQuestionsScreenState();
}

class _AdminsQuestionsScreenState extends State<AdminsQuestionsScreen> {
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
              appBar: AppBar(elevation: 0),
              body: RefreshIndicator(
                onRefresh: () async {
                  InfoHubCubit.get(context).getNews();
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.bottomRight,
                      height: size.height * .1,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: adminColor,
                      ),
                      child: Text(
                        'أسئلة متكررة !',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * .09,
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
                                  color: adminColor,
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        child: Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    ((snapshot.data!
                                                                as QuerySnapshot)
                                                            .docs[index]
                                                            .data()
                                                        as Map)['question'],
                                                    style: GoogleFonts.amiri(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: adminColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    child: Divider(
                                                      thickness: 2,
                                                      color: adminColor,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.calendar_today,
                                                        size: 20,
                                                        color: adminColor,
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
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: adminColor,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      IconButton(
                                                        onPressed: () async {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .runTransaction(
                                                                  (Transaction
                                                                      myTransaction) async {
                                                            await myTransaction
                                                                .delete((snapshot
                                                                            .data!
                                                                        as QuerySnapshot)
                                                                    .docs[index]
                                                                    .reference);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: adminColor,
                                                          size: size.width * .07,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
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
                                    color: adminColor,
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
            ),
          );
        },
      ),
    );
  }
}
