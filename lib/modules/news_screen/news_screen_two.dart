import 'package:algad_infohub/modules/news_screen/news_details.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/conponents.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    child: Container(
                      width: double.infinity,
                      height: size.height * .07,
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(.5),
                          ),
                          hintText: 'ابحث',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(.7),
                          ),
                        ),
                        autofocus: false,
                        onChanged: (val) {
                          setState(() {
                            name = val;
                            news = val;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('myNews')
                            .snapshots(),
                        builder: (context, snapshots) {
                          return (snapshots.connectionState ==
                                  ConnectionState.waiting)
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: newsColor,
                                  ),
                                )
                              : ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var data = snapshots.data!.docs[index]
                                        .data() as Map<String, dynamic>;
                                    if (name.isEmpty && news.isEmpty) {
                                      return Container();
                                    }
                                    if (data['name']
                                            .toString()
                                            .toLowerCase()
                                            .contains(name.toLowerCase()) ||
                                        data['new']
                                            .toString()
                                            .toLowerCase()
                                            .contains(news.toLowerCase())) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                create: (context) =>
                                                    InfoHubCubit(),
                                                child: NewsDetailsScreen(
                                                  news: data['new'],
                                                  name: data['name'],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin:
                                              EdgeInsets.all(size.width * .03),
                                          padding: EdgeInsets.symmetric(
                                            vertical: size.height * .01,
                                            horizontal: size.width * .02,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  offset: Offset(4, 4),
                                                  blurRadius: 3,
                                                  spreadRadius: 2)
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                size.width * .01),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                 data['name'],
                                                  style: TextStyle(
                                                    color: newsColor,
                                                    fontSize: size.width * .06,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height * .001,
                                                ),
                                                Text(
                                                 data['new'],
                                                  style: TextStyle(
                                                    fontSize: size.width * .05,
                                                    color: Colors.black,
                                                    height: size.height * .0015,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                      Icons.calendar_month,
                                                      color: newsColor,
                                                      size: size.width * .05,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                    data['date'],
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.width * .035,
                                                        color: newsColor,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      'اقرأ المزيد',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: newsColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward,
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
                                    }
                                    return Container();
                                  },
                                  itemCount: snapshots.data!.docs.length,
                                );
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
