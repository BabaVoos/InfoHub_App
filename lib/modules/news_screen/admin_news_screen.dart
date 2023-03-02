import 'package:algad_infohub/modules/news_screen/news_details.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// class NewsScreen extends StatefulWidget {
//   const NewsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NewsScreen> createState() => _NewsScreenState();
// }
//
// class _NewsScreenState extends State<NewsScreen> {
//   CollectionReference newsRef = FirebaseFirestore.instance.collection('myNews');
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return BlocProvider(
//       create: (context) => InfoHubCubit(),
//       child: BlocConsumer<InfoHubCubit, InfoHubState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return Directionality(
//             textDirection: TextDirection.rtl,
//             child: Scaffold(
//               appBar: AppBar(
//                 title: Text("رجوع"),
//                 backgroundColor: adminColor,
//                 elevation: 0,
//               ),
//               body: Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(size.width * .02),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: adminColor,
//                     ),
//                     child: Text(
//                       'أخر الأخبار',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: size.width * .05,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                     ),
//                     child: StreamBuilder(
//                       stream: newsRef.snapshots(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.waiting) {
//                           return Center(child: CircularProgressIndicator(color: adminColor,));
//                         }
//                         if(snapshot.hasData) {
//                           return ListView.builder(
//                             physics: BouncingScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => BlocProvider(
//                                         create: (context) => InfoHubCubit(),
//                                         child: NewsDetailsScreen(
//                                           news:
//                                           ((snapshot.data! as QuerySnapshot)
//                                               .docs[index]
//                                               .data() as Map)['new'],
//                                           name:
//                                           ((snapshot.data! as QuerySnapshot)
//                                               .docs[index]
//                                               .data() as Map)['name'],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.all(15),
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 15, vertical: 20),
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[200],
//                                     borderRadius: BorderRadius.circular(10),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: Colors.grey,
//                                           offset: Offset(4, 4),
//                                           blurRadius: 3,
//                                           spreadRadius: 2)
//                                     ],
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         ((snapshot.data! as QuerySnapshot)
//                                             .docs[index]
//                                             .data() as Map)['name'],
//                                         style: TextStyle(
//                                           color: adminColor,
//                                           fontSize: size.width * .06,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text(
//                                         ((snapshot.data! as QuerySnapshot)
//                                             .docs[index]
//                                             .data() as Map)['new'],
//                                         style: GoogleFonts.readexPro(
//                                           fontSize: size.width * .04,
//                                           color: Colors.black,
//                                           height: 2,
//                                         ),
//                                         maxLines: 2,
//                                       ),
//                                       SizedBox(
//                                         height: 15,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets
//                                             .symmetric(
//                                             vertical: 5),
//                                         child: Divider(
//                                           thickness: 2,
//                                           color: jobsColor,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 15,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.calendar_month,
//                                             color: Colors.black,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             ((snapshot.data!
//                                             as QuerySnapshot)
//                                                 .docs[index]
//                                                 .data() as Map)['date'],
//                                             style: TextStyle(
//                                               fontSize: 15,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           Spacer(),
//                                           Text(
//                                             'اقرأ المزيد',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: adminColor,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 5,
//                                           ),
//                                           Icon(
//                                             Icons.arrow_forward,
//                                             size: 15,
//                                             color: adminColor,
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                             itemCount:
//                             (snapshot.data! as QuerySnapshot).docs.length,
//                           );
//                         }
//                         return Text('');
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


class AdminsNewsScreen extends StatefulWidget {
  const AdminsNewsScreen({Key? key}) : super(key: key);

  @override
  State<AdminsNewsScreen> createState() => _AdminsNewsScreenState();
}

class _AdminsNewsScreenState extends State<AdminsNewsScreen> {
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
                title: Text("رجوع"),
                backgroundColor: adminColor,
                elevation: 0,
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  InfoHubCubit.get(context).getNews();
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: adminColor,
                      ),
                      child: Expanded(
                        child: Text(
                          'أخر الأخبار',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * .09,
                          ),
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
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator(color: adminColor,));
                            }
                            if(snapshot.hasData) {
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
                                              news:
                                              ((snapshot.data! as QuerySnapshot)
                                                  .docs[index]
                                                  .data() as Map)['new'],
                                              name:
                                              ((snapshot.data! as QuerySnapshot)
                                                  .docs[index]
                                                  .data() as Map)['name'],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(15),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 20),
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
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ((snapshot.data! as QuerySnapshot)
                                                .docs[index]
                                                .data() as Map)['name'],
                                            style: TextStyle(
                                              color: adminColor,
                                              fontSize: size.width * .06,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            ((snapshot.data! as QuerySnapshot)
                                                .docs[index]
                                                .data() as Map)['new'],
                                            style: GoogleFonts.readexPro(
                                              fontSize: size.width * .04,
                                              color: Colors.black,
                                              height: 2,
                                            ),
                                            maxLines: 2,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                vertical: 5),
                                            child: Divider(
                                              thickness: 2,
                                              color: jobsColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                                color: Colors.black,
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
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Spacer(),
                                              IconButton(
                                                onPressed: () async {
                                                  await FirebaseFirestore.instance
                                                      .runTransaction((Transaction
                                                  myTransaction) async {
                                                    await myTransaction.delete(
                                                        (snapshot.data!
                                                        as QuerySnapshot)
                                                            .docs[index]
                                                            .reference);
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: adminColor,
                                                  size: 40,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
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
            ),
          );
        },
      ),
    );
  }
}
