import 'package:algad_infohub/Authintication/LoginWithGoogle/login.dart';
import 'package:algad_infohub/Authintication/LoginWithGoogle/loginWithGoogle.dart';
import 'package:algad_infohub/Authintication/login/login_screen.dart';
import 'package:algad_infohub/modules/addresses_screen/addresses_screen.dart';
import 'package:algad_infohub/modules/addresses_screen/addresses_screen_two.dart';
import 'package:algad_infohub/modules/jobs_screen/jobs_screen.dart';
import 'package:algad_infohub/modules/jobs_screen/jobs_screen_two.dart';
import 'package:algad_infohub/modules/news_screen/news_screen_two.dart';
import 'package:algad_infohub/modules/questions_screen/questions_screen.dart';
import 'package:algad_infohub/modules/questions_screen/questions_screen_2.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Authintication/cubit/cubit.dart';
import '../news_screen/news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // InfoHubCubit.get(context).getFcmTokenAndUpdateIt();
    // InfoHubCubit.get(context).showNotification("as", "s");
    // InfoHubCubit.get(context).listenToNotification();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<InfoHubCubit, InfoHubState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('images/back9.jpg'),
                fit: BoxFit.fill,
              )),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                // appBar: AppBar(
                //   actions: [
                //     IconButton(
                //       onPressed: () {
                //         FirebaseAuth.instance.signOut();
                //         Navigator.pushReplacement(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => BlocProvider(
                //                 create: (context) => AuthCubit(),
                //                 child: LoginMainScreen(),
                //               ),
                //             ));
                //       },
                //       icon: Icon(
                //         Icons.logout,
                //       ),
                //     ),
                //   ],
                // ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: size.height * .3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/rens.jpeg"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              size.width * .4,
                            ),
                            bottomRight: Radius.circular(size.width * .06),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .05,
                      ),
                      Text(
                        'خدمة اخبار اللاجئين',
                        style: GoogleFonts.arapey(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * .1,
                        ),
                      ),
                      SizedBox(
                        height: size.height * .05,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio: 1.1,
                          crossAxisCount: 2,
                          mainAxisSpacing: size.height * .01,
                          crossAxisSpacing: size.width * .04,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                        create: (context) => InfoHubCubit(),
                                        child: NewsScreen()),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.grey[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      IconBroken.Notification,
                                      size: size.width * .15,
                                    ),
                                    Text(
                                      'أنباء مهمة',
                                      style: GoogleFonts.amiri(
                                        fontSize: size.width * .1,
                                      ),
                                    )
                                  ],
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                        create: (context) => InfoHubCubit(),
                                        child: JobsScreen()),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.grey[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      IconBroken.Work,
                                      size: size.width * .15,
                                    ),
                                    Text(
                                      'وظائف',
                                      style: GoogleFonts.amiri(
                                        fontSize: size.width * .1,
                                      ),
                                    )
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                        create: (context) => InfoHubCubit(),
                                        child: QuestionsScreen()),
                                  ),
                                );
                              },
                              child: Container(
                                child: Card(
                                  color: Colors.grey[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        IconBroken.Info_Square,
                                        size: size.width * .15,
                                      ),
                                      Text(
                                        'استفسارات',
                                        style: GoogleFonts.amiri(
                                          fontSize: size.width * .1,
                                        ),
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                        create: (context) => InfoHubCubit(),
                                        child: AddressesScreenTwo()),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.grey[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      IconBroken.Location,
                                      size: size.width * .15,
                                    ),
                                    Text(
                                      'عناوين',
                                      style: GoogleFonts.amiri(
                                        fontSize: size.width * .1,
                                      ),
                                    )
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
