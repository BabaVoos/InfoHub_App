import 'dart:io';

import 'package:algad_infohub/modules/Admin/addresses_add_screen.dart';
import 'package:algad_infohub/modules/Admin/control_screen.dart';
import 'package:algad_infohub/modules/Admin/jobs_add_screen.dart';
import 'package:algad_infohub/modules/Admin/news_add_screen.dart';
import 'package:algad_infohub/modules/Admin/questions_add_screen.dart';
import 'package:algad_infohub/modules/news_screen/admin_news_screen.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../main.dart';

class InfoHubCubit extends Cubit<InfoHubState> {
  InfoHubCubit() : super(InfoHubInitialState());

  static InfoHubCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    AddNewsScreen(),
    AddQuestionsScreen(),
    AddJobsScreen(),
    ControlScreen(),
  ];

  List<String> titles = [
    'News Screen',
    "Questions Screen",
    "Jobs Screen",
    "Control Screen",
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }

  void newCreate({
    required String news,
    required String name,
    required String date,
  }) {
    FirebaseFirestore.instance
        .collection('myNews')
        .doc('${DateTime.now()}')
        .set({
      'new': news,
      'name': name,
      'date': date,
    }).then((value) {
      emit(AddNewsSuccessState());
    }).catchError((error) {
      emit(AddNewsErrorState(error.toString()));
    });
  }

  // get News data
  List<Map> news = [];

  void getNews() {
    FirebaseFirestore.instance.collection('myNews').get().then((value) {
      news.clear();
      for (var document in value.docs) {
        news.add(document.data());
      }
      emit(GetNewsSuccessState());
    }).catchError((error) {
      emit(GetNewsErrorState(error.toString()));
    });
  }

  // News Delete
  void deleteNews() {
    FirebaseFirestore.instance
        .collection('myNews')
        .doc()
        .delete()
        .then((value) {
      print('asda');
      emit(DeleteNewsSuccessState());
    }).catchError((error) {
      print('ooooo');
      emit(DeleteNewsErrorState(error.toString()));
    });
    getNews();
  }

  // questionCreate
  void questionCreate({
    required String question,
    required String answer,
    required String date,
  }) {
    FirebaseFirestore.instance.collection('myQuestions').doc().set({
      'question': question,
      'answer': answer,
      'date': date,
    }).then((value) {
      emit(AddQuestionsSuccessState());
    }).catchError((error) {
      emit(AddQuestionsErrorState(error.toString()));
    });
  }

  List<Map> questions = [];

  void getQuestions() {
    FirebaseFirestore.instance.collection('myQuestions').get().then((value) {
      questions.clear();
      for (var document in value.docs) {
        questions.add(document.data());
      }
      emit(GetQuestionsSuccessState());
    }).catchError((error) {
      emit(GetQuestionsErrorState(error.toString()));
    });
  }

  void jobsCreate({
    required String name,
    required String job,
    required String date,
  }) {
    FirebaseFirestore.instance.collection('myJobs').doc().set({
      'job': job,
      'date': date,
      'name': name,
    }).then((value) {
      emit(AddJobsSuccessState());
    }).catchError((error) {
      emit(AddJobsErrorState(error.toString()));
    });
  }

  void AddressesCreate({
    required String name,
    required String addresses,
    required date,
  }) {
    FirebaseFirestore.instance.collection('myAddresses').add({
      'addresses': addresses,
      'name': name,
      'date' : FieldValue.serverTimestamp(),
    }).then((value) {
      emit(AddAddressesSuccessState());
    }).catchError((error) {
      emit(AddAddressesErrorState(error.toString()));
    });
  }

  List<Map> jobs = [];

  void getJobs() {
    FirebaseFirestore.instance.collection('myJobs').get().then((value) {
      jobs.clear();
      for (var document in value.docs) {
        jobs.add(document.data());
      }
      emit(GetJobsSuccessState());
    }).catchError((error) {
      emit(GetJobsErrorState(error.toString()));
    });
  }

  void getFcmTokenAndUpdateIt() {
    FirebaseMessaging.instance.getToken().then((String? fcmToken) {
      FirebaseFirestore.instance
          .collection('myUsers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"fcmToken": fcmToken});
    });
  }

  //
  // Future<void> showNotification(String title, String body) async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //   AndroidNotificationDetails(
  //     'defaultNotification',
  //     'Default Notifications',
  //     channelDescription: 'your channel description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     ticker: 'ticker',
  //   );
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //   );
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     title,
  //     body,
  //     notificationDetails,
  //     payload: 'item x',
  //   );
  // }
  //
  // void listenToNotification() {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Got a message whilst in the foreground!');
  //     print('Message data: ${message.data}');
  //
  //     if (message.notification != null) {
  //       print(
  //           'Message also contained a notification: ${message.notification!.title}');
  //       showNotification(
  //         message.notification!.title!,
  //         message.notification!.body!,
  //       );
  //     }
  //   });
  // }

}
