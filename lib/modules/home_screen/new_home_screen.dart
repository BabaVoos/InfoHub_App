import 'package:algad_infohub/modules/news_screen/new_news_screen.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../addresses_screen/new_addresses_screen.dart';
import '../jobs_screen/new_jobs_screen.dart';
import '../questions_screen/new_questions_screen.dart';

class NewHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text(
              'خدمة أخبار اللاجئين',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: mainColor,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(
                  text: 'أخبار',
                ),
                Tab(
                  text: 'وظائف',
                ),
                Tab(
                  text: 'استفسارات',
                ),
                Tab(
                  text: 'عناوين',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const NewNewsScreen(),
              NewJobsScreen(),
              const NewQuestionsScreen(),
              NewAddressesScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
