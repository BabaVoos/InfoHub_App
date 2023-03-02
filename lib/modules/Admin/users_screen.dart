import 'package:algad_infohub/modules/questions_screen/questions_details_screen.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String name = "";
  String phone = "";
  String nationality = "";
  String gender = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Users',
          ),
          backgroundColor: adminColor,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * .05,
                  vertical: size.height * .02,
                ),
                alignment: Alignment.bottomRight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: adminColor,
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
                        name = val;
                      });
                    },
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('myUsers')
                        .snapshots(),
                    builder: (context, snapshots) {
                      return (snapshots.connectionState ==
                          ConnectionState.waiting)
                          ? Center(
                        child: CircularProgressIndicator(),
                      )
                          : ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = snapshots.data!.docs[index]
                              .data() as Map<String, dynamic>;
                          if (name.isEmpty) {
                            return Column(
                              children: [
                                Padding(
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
                                            data['email'],
                                            style: TextStyle(
                                              fontSize:
                                              size.width * .05,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
                                          Divider(),
                                          Text(
                                            data['phone'],
                                            style: TextStyle(
                                                fontSize:
                                                size.width *
                                                    .05,
                                                fontWeight:
                                                FontWeight.bold,
                                                height:
                                                size.height *
                                                    .0015),
                                            maxLines: 2,
                                            overflow: TextOverflow
                                                .ellipsis,
                                          ),
                                          Divider(),
                                          Text(
                                            data['gender'],
                                            style: TextStyle(
                                              fontSize:
                                              size.width *
                                                  .05,
                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                            ),
                                          ),
                                          Divider(),
                                          Text(
                                            data['nationality'],
                                            style: TextStyle(
                                              fontSize:
                                              size.width *
                                                  .05,
                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          if (data['username']
                              .toString()
                              .toLowerCase()
                              .contains(
                              name.toLowerCase()) ||
                              data['gender']
                                  .toString()
                                  .toLowerCase()
                                  .contains(gender.toLowerCase())) {
                            return Padding(
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
                                        data['username'],
                                        style: TextStyle(
                                          fontSize:
                                          size.width * .05,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),
                                      Divider(),
                                      Text(
                                        data['phone'],
                                        style: TextStyle(
                                            fontSize:
                                            size.width *
                                                .05,
                                            fontWeight:
                                            FontWeight.bold,
                                            height:
                                            size.height *
                                                .0015),
                                        maxLines: 2,
                                        overflow: TextOverflow
                                            .ellipsis,
                                      ),
                                      Divider(),
                                      Text(
                                        data['gender'],
                                        style: TextStyle(
                                          fontSize:
                                          size.width *
                                              .05,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                        ),
                                      ),
                                      Divider(),
                                      Text(
                                        data['nationality'],
                                        style: TextStyle(
                                          fontSize:
                                          size.width *
                                              .05,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                        ),
                                      )
                                    ],
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
            ],
          ),
        ),
      ),
    );
  }
}
