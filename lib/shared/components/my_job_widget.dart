import 'package:algad_infohub/modules/jobs_screen/cubit/jobs_cubit.dart';
import 'package:algad_infohub/shared/components/main_widget.dart';
import 'package:algad_infohub/shared/constants/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../modules/jobs_screen/jobs_details_screen.dart';
import '../colors.dart';

class MyJobWidget extends StatelessWidget {
  CollectionReference jobsRef = FirebaseFirestore.instance.collection('myJobs');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: jobsRef.orderBy('publishDate', descending: true).snapshots(),
            builder: (context, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                );
              }
              if (snapshots.hasData) {
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index];
                    var date =
                        SharedFunctions.dateFormatter(data['publishDate']);
                    return MainWidget(
                      id: data['id'],
                      title: data['organizationName'],
                      subTitle: data['job'],
                      date: date,
                      onPressed: () {Navigator.push(context, MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => JobsCubit(),
                          child: JobsDetailsScreen(
                            id: data['id'],
                            job: data['job'],
                            name: data['organizationName'],
                          ),
                        ),
                      ),);},
                    );
                  },
                  itemCount: (snapshots.data!).docs.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    height: 30,
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
