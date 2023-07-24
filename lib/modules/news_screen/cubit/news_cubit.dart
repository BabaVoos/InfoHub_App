import 'package:algad_infohub/Authintication/helpers/my_easyloading.dart';
import 'package:algad_infohub/models/news.dart';
import 'package:algad_infohub/modules/news_screen/cubit/news_states.dart';
import 'package:algad_infohub/shared/constants/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(
        context,
      );


  void newCreate({
    required String news,
    required String organizationName,
  }) async {
    final docUid = FirebaseFirestore.instance
        .collection(
          "myNews",
        )
        .doc();

    News model = News(
      id: docUid.id,
      organizationName: organizationName,
      news: news,
      publishDate: Timestamp.now(),
      read: false,
    );

    await docUid.set(model.toJson()).then((value) {
      SharedFunctions.sendNotification(
        title: model.organizationName,
        body: model.news,
      );
      emit(AddNewsSuccessState());
    }).catchError((error) {
      emit(AddNewsErrorState(error.toString()));
    });
  }

  void newsDelete({
    required String id,
  }) {
    FirebaseFirestore.instance
        .collection('myNews')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteNewsSuccessState());
    }).catchError((error) {
      emit(DeleteNewsErrorState(error.toString()));
    });
  }

  void newsUpdate({
    required String id,
    required String news,
    required String organizationName,
    context,
  }) {
    FirebaseFirestore.instance.collection('myNews').doc(id).update(
      {
        'organizationName': organizationName,
        'news': news,
      },
    ).then((value) {
      showSuccessMessage(
        'Updated Successfully',
      );
      Navigator.pop(context);
      emit(
        UpdateNewsSuccessState(),
      );
    }).catchError((error) {
      emit(
        UpdateNewsErrorState(
          error.toString(),
        ),
      );
    });
  }
}
