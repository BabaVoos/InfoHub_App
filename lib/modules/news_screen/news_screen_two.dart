import 'package:algad_infohub/modules/news_screen/cubit/news_cubit.dart';
import 'package:algad_infohub/modules/news_screen/news_details.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:algad_infohub/shared/components/main_widget.dart';
import 'package:algad_infohub/shared/components/my_app_bar.dart';
import 'package:algad_infohub/shared/components/search_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

import 'cubit/news_states.dart';

class NewsScreenTwo extends StatefulWidget {
  const NewsScreenTwo({Key? key}) : super(key: key);

  @override
  State<NewsScreenTwo> createState() => _NewsScreenTwoState();
}

class _NewsScreenTwoState extends State<NewsScreenTwo> {
  String name = '';
  String news = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColor.withOpacity(.4),
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
                    news = val;
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
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('myNews').snapshots(),
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
                        if (name.isEmpty && news.isEmpty) {
                          return Container();
                        }
                        if (data['organizationName']
                                .toString()
                                .toLowerCase()
                                .contains(name.toLowerCase()) ||
                            data['news']
                                .toString()
                                .toLowerCase()
                                .contains(news.toLowerCase())) {
                          return Column(
                            children: [
                              MainWidget(
                                id: data['id'],
                                title: data['organizationName'],
                                subTitle: data['news'],
                                date: date,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => NewsCubit(),
                                      child: NewsDetailsScreen(
                                        id: data['id'],
                                        news: data['news'],
                                        name: data['organizationName'],
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
      );
}
