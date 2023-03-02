import 'package:algad_infohub/modules/news_screen/news_details.dart';
import 'package:algad_infohub/modules/news_screen/news_screen_two.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/conponents.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  CollectionReference newsRef = FirebaseFirestore.instance.collection('myNews');

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
                title: Text("رجوع"),
                backgroundColor: newsColor,
                elevation: 0,
                actions: [
                  IconButton(
                    onPressed: () {
                      navigateTo(
                        context,
                        NewsScreenTwo(),
                      );
                    },
                    icon: Icon(IconBroken.Search),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * .05,
                      vertical: size.height * .02,
                    ),
                    alignment: Alignment.bottomRight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: newsColor,
                    ),
                    child: Text(
                      'أخر الأخبار',
                      style: TextStyle(
                        color: Colors.white,
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
                      child: StreamBuilder(
                        stream: newsRef.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: newsColor,
                            ),);
                          }
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) => InfoHubCubit(),
                                          child: NewsDetailsScreen(
                                            news: ((snapshot.data!
                                                    as QuerySnapshot)
                                                .docs[index]
                                                .data() as Map)['new'],
                                            name: ((snapshot.data!
                                                    as QuerySnapshot)
                                                .docs[index]
                                                .data() as Map)['name'],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(size.width * .03),
                                    padding: EdgeInsets.symmetric(
                                      vertical: size.height * .01,
                                      horizontal: size.width * .02,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(4, 4),
                                            blurRadius: 3,
                                            spreadRadius: 2)
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(size.width * .01),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (snapshot.data as QuerySnapshot)
                                                .docs[index]
                                                .reference
                                                .id,
                                          ),
                                          Text(
                                            ((snapshot.data! as QuerySnapshot)
                                                .docs[index]
                                                .data() as Map)['name'],
                                            style: TextStyle(
                                              color: newsColor,
                                              fontSize: size.width * .06,
                                              height: 1,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * .01,
                                          ),
                                          Text(
                                            ((snapshot.data! as QuerySnapshot)
                                                .docs[index]
                                                .data() as Map)['new'],
                                            style: TextStyle(
                                              fontSize: size.width * .05,
                                              color: Colors.black,
                                              height: size.height * .0015,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: size.height * .01,
                                              horizontal: size.width * .3,
                                            ),
                                            child: Divider(
                                              thickness: 2,
                                              color: newsColor,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                IconBroken.Calendar,
                                                color: newsColor,
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
                                                  fontSize: size.width * .035,
                                                  color: newsColor,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                'اقرأ المزيد',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: newsColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                IconBroken.Arrow___Left_2,
                                                size: 15,
                                                color: newsColor,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount:
                                  (snapshot.data! as QuerySnapshot).docs.length,
                            );
                          }
                          return Text('');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
