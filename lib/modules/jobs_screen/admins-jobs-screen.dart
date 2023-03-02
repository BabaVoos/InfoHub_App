import 'package:algad_infohub/modules/jobs_screen/jobs_details_screen.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminsJobsScreen extends StatefulWidget {
  const AdminsJobsScreen({Key? key}) : super(key: key);

  @override
  State<AdminsJobsScreen> createState() => _AdminsJobsScreenState();
}

class _AdminsJobsScreenState extends State<AdminsJobsScreen> {
  CollectionReference jobsRef = FirebaseFirestore.instance.collection('myJobs');

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
                elevation: 0,
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  InfoHubCubit.get(context).getNews();
                },
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.all(10),
                      height: size.height * .1,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: adminColor,
                      ),
                      child: Text(
                        'وظائف',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * .09,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StreamBuilder(
                            stream: jobsRef.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  color: jobsColor,
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
                                              child: JobsDetailsScreen(
                                                job: ((snapshot.data!
                                                        as QuerySnapshot)
                                                    .docs[index]
                                                    .data() as Map)['job'],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: size.height * .01,
                                          horizontal: size.width * .02,
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
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
                                                const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ((snapshot.data!
                                                  as QuerySnapshot)
                                                      .docs[index]
                                                      .data() as Map)['name'],
                                                  style:
                                                      GoogleFonts.readexPro(
                                                    fontSize:
                                                        size.width * .046,
                                                    color: Colors.black,
                                                    height: 2,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: Divider(
                                                    thickness: 2,
                                                    color: jobsColor,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.calendar_month,
                                                      color: Colors.black,
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
                                                        color: Colors.black,
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
                                                        color:
                                                            adminColor,
                                                        size: 40,
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                    color: jobsColor,
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
