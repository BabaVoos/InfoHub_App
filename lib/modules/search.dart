import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'questions_screen/questions_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
              ),
              hintText: 'Search...',
            ),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('myQuestions').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data() as Map<String, dynamic>;
                    if(name.isEmpty){
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
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
                          child: Expanded(
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
                                      height: size.height * .001,
                                    ),
                                    Text(
                                     data['answer'],
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
                                        horizontal: size.width * .3,
                                      ),
                                      child: Divider(
                                        thickness: 2,
                                        color: questions,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: size.width * .05,
                                          color: questions,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                         data['date'],
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
                                          Icons.arrow_forward,
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
                        ),
                      );
                    }
                    if(data['question'].toString().toLowerCase().contains(name.toLowerCase())){
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
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
                          child: Expanded(
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
                                      height: size.height * .001,
                                    ),
                                    Text(
                                      data['answer'],
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
                                        horizontal: size.width * .3,
                                      ),
                                      child: Divider(
                                        thickness: 2,
                                        color: questions,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: size.width * .05,
                                          color: questions,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          data['date'],
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
                                          Icons.arrow_forward,
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
                        ),
                      );
                    }
                    return Container();
                  },
                  itemCount: snapshots.data!.docs.length,
                );
        },
      ),
    );
  }
}
