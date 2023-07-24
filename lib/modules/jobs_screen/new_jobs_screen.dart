import 'package:algad_infohub/modules/jobs_screen/jobs_screen_two.dart';
import 'package:algad_infohub/shared/components/conponents.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:algad_infohub/shared/components/my_job_widget.dart';
import 'package:flutter/material.dart';

import '../../shared/colors.dart';

class NewJobsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton:  CircleAvatar(
          backgroundColor: mainColor,
          radius: 25,
          child: IconButton(
            onPressed: () {
              navigateTo(
                context,
                JobsScreenTwo(),
              );
            },
            icon: Icon(IconBroken.Search),
          ),
        ),
        body: Column(
          children: [
            MyJobWidget(),
          ],
        ),
      ),
    );
  }
}
