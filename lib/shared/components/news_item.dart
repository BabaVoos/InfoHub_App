import 'package:algad_infohub/modules/news_screen/cubit/news_cubit.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:algad_infohub/shared/components/main_widget.dart';
import 'package:algad_infohub/shared/constants/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../modules/news_screen/news_details.dart';
import '../colors.dart';

class NewsItem extends StatelessWidget {
  CollectionReference newsRef = FirebaseFirestore.instance.collection('myNews');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(
          10,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: newsRef.orderBy('publishDate', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ),
              );
            }
            if (snapshot.hasData) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  var date = SharedFunctions.dateFormatter(
                    data['publishDate'],
                  );
                  return MainWidget(
                    id: data['id'],
                    title: data['organizationName'],
                    subTitle: data['news'],
                    date: date,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => NewsCubit(),
                            child: NewsDetailsScreen(
                              id: data['id'],
                              news: data['news'],
                              name: data['organizationName'],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: 30,
                  color: mainColor,
                  thickness: 1,
                ),
                itemCount: (snapshot.data!).docs.length,
              );
            }
            return const Text('');
          },
        ),
      ),
    );
  }
}
