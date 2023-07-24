import 'package:algad_infohub/modules/jobs_screen/cubit/jobs_cubit.dart';
import 'package:algad_infohub/modules/jobs_screen/jobs_details_screen.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:algad_infohub/shared/components/main_widget.dart';
import 'package:algad_infohub/shared/components/my_app_bar.dart';
import 'package:algad_infohub/shared/components/search_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

class JobsScreenTwo extends StatefulWidget {
  const JobsScreenTwo({Key? key}) : super(key: key);

  @override
  State<JobsScreenTwo> createState() => _JobsScreenTwoState();
}

class _JobsScreenTwoState extends State<JobsScreenTwo> {
  String name = '';

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
                setState(
                  () {
                    name = val;
                  },
                );
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('myJobs').snapshots(),
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
                          var date = intl.DateFormat('Md')
                              .format(data['publishDate'].toDate())
                              .toString();
                          if (name.isEmpty) {
                            return Container();
                          }
                          if (data['organizationName']
                              .toString()
                              .toLowerCase()
                              .contains(name.toLowerCase())) {
                            return Column(
                              children: [
                                MainWidget(
                                  id: data['id'],
                                  title: data['organizationName'],
                                  subTitle: data['job'],
                                  date: date,
                                  onPressed: () {
                                    Navigator.push(context,MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => JobsCubit(),
                                        child: JobsDetailsScreen(
                                          name: data['name'],
                                          id: data['id'],
                                          job: data['job'],
                                        ),
                                      ),
                                    ),);
                                  },
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
