import 'package:algad_infohub/models/jobs.dart';
import 'package:algad_infohub/modules/jobs_screen/cubit/jobs_states.dart';
import 'package:algad_infohub/shared/constants/const.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Authintication/helpers/my_easyloading.dart';

class JobsCubit extends Cubit<JobsStates> {
  JobsCubit() : super(JobsInitialState());

  static JobsCubit get(context) => BlocProvider.of(
        context,
      );


  void jobCreate({
    required String job,
    required String organizationName,
  }) async {
    final docUid = FirebaseFirestore.instance
        .collection(
          "myJobs",
        )
        .doc();

    Jobs model = Jobs(
      id: docUid.id,
      organizationName: organizationName,
      job: job,
      publishDate: Timestamp.now(),
    );

    await docUid
        .set(
      model.toJson(),
    )
        .then((value) {
      SharedFunctions.sendNotification(
        title: model.organizationName,
        body: model.job,
      );
      emit(AddJobsSuccessState());
    }).catchError((error) {
      emit(AddJobsErrorState(error.toString()));
    });
  }

  void jobDelete({
    required String id,
  }) {
    FirebaseFirestore.instance
        .collection('myJobs')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteJobSuccessState());
    }).catchError((error) {
      emit(DeleteJobErrorState(error.toString()));
    });
  }

  void jobUpdate({
    required String id,
    required String job,
    required String organizationName,
    context,
  }) {
    FirebaseFirestore.instance.collection('myJobs').doc(id).update(
      {
        'organizationName': organizationName,
        'job': job,
      },
    ).then((value) {
      showSuccessMessage('Updated Successfully',);
      Navigator.pop(context);
      emit(
        UpdateJobSuccessState(),
      );
    }).catchError((error) {
      emit(
        UpdateJobErrorState(
          error.toString(),
        ),
      );
    });
  }
}
