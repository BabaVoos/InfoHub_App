import 'package:algad_infohub/modules/jobs_screen/jobs_details_screen.dart';
import 'package:algad_infohub/modules/jobs_screen/jobs_screen_two.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/conponents.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({Key? key}) : super(key: key);

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
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
                leading: IconButton(
                  icon: Icon(IconBroken.Arrow___Right_2),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                titleSpacing: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                title: Text(
                  'رجوع',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                backgroundColor: jobsColor,
                elevation: 0,
                actions: [
                  IconButton(
                    onPressed: () {
                      navigateTo(context, JobsScreenTwo(),);
                    },
                    icon: Icon(IconBroken.Search,),
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  InfoHubCubit.get(context).getNews();
                },
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
                        color: jobsColor,
                      ),
                      child: Text(
                        'وظائف',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * .08,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
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
                                          horizontal: size.width * .04,
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
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
                                              size.width * .03,
                                            ),
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
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height * .001,
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
                                                    color: jobsColor,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.calendar_month,
                                                      color: Colors.black,
                                                      size: size.width * .05,
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
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      'اقرأ المزيد',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward,
                                                      size: 15,
                                                      color: Colors.black,
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
