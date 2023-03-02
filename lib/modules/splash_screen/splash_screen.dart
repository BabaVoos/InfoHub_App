import 'dart:async';
import 'package:algad_infohub/modules/home_screen/home_screen.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
          () =>
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(create:(context) => InfoHubCubit(), child: HomeScreen(),),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [
                Colors.black,
                Colors.black,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'خدمة أخبار اللاجئين',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: size.width * .1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: size.height * .25,
                    width: size.width * .6,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'images/Picture1.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Text(
                    'ReNS',
                    style: GoogleFonts.wallpoet(
                      fontSize: size.width * .2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: size.width * .02,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * .3,
                ),
                child: LinearProgressIndicator(
                  color: Colors.green,
                  backgroundColor: Colors.green.withOpacity(
                    .3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
