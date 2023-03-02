import 'package:algad_infohub/modules/Admin/addresses_add_screen.dart';
import 'package:algad_infohub/modules/Admin/users_screen.dart';
import 'package:algad_infohub/modules/addresses_screen/admin_addresses_screen.dart';
import 'package:algad_infohub/modules/jobs_screen/admins-jobs-screen.dart';
import 'package:algad_infohub/modules/news_screen/admin_news_screen.dart';
import 'package:algad_infohub/modules/questions_screen/admins_questions_screen.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/cubit/cubit.dart';


class ControlScreen extends StatelessWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: adminColor,
      body: ListView(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: size.width * .06, vertical: size.height * .01),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => InfoHubCubit(),
                      child: AddAddressesScreen(),
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(size.width * .05),
                  child: Column(
                    children: [
                      Icon(
                        Icons.location_city_rounded,
                        size: size.width * .15,
                      ),
                      Text(
                        'Add Locations',
                        style: GoogleFonts.amiri(
                          fontSize: size.width * .1,
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: size.width * .06, vertical: size.height * .01),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => InfoHubCubit(),
                      child: UsersScreen(),
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(size.width * .05),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        size: size.width * .15,
                      ),
                      Text(
                        'Users',
                        style: GoogleFonts.amiri(
                          fontSize: size.width * .1,
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: size.width * .06, vertical: size.height * .01),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => InfoHubCubit(),
                      child: AdminsNewsScreen(),
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(size.width * .05),
                  child: Column(
                    children: [
                      Icon(
                        Icons.newspaper_sharp,
                        size: size.width * .15,
                      ),
                      Text(
                        'News',
                        style: GoogleFonts.amiri(
                          fontSize: size.width * .1,
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: size.width * .06, vertical: size.height * .01),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                        create: (context) => InfoHubCubit(),
                        child: AdminsQuestionsScreen()),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(size.width * .05),
                  child: Column(
                    children: [
                      Icon(
                        Icons.question_answer,
                        size: size.width * .15,
                      ),
                      Text(
                        'Questions',
                        style: GoogleFonts.amiri(
                          fontSize: size.width * .1,
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: size.width * .06, vertical: size.height * .01),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => InfoHubCubit(),
                      child: AdminsJobsScreen(),
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(size.width * .05),
                  child: Column(
                    children: [
                      Icon(
                        Icons.work,
                        size: size.width * .15,
                      ),
                      Text(
                        'Jobs',
                        style: GoogleFonts.amiri(
                          fontSize: size.width * .1,
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: size.width * .06, vertical: size.height * .01),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => InfoHubCubit(),
                      child: AdminAddressesScreen(),
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(size.width * .05),
                  child: Column(
                    children: [
                      Icon(
                        Icons.location_city_sharp,
                        size: size.width * .15,
                      ),
                      Text(
                        'Addresses',
                        style: GoogleFonts.amiri(
                          fontSize: size.width * .1,
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
