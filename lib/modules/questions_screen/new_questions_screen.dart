import 'package:algad_infohub/modules/questions_screen/questions_screen_2.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/components/my_ques_widget.dart';

class NewQuestionsScreen extends StatelessWidget {
  const NewQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: CircleAvatar(
          backgroundColor: mainColor,
          radius: 25,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuestionsScreenTwo(),
                ),
              );
            },
            icon: const Icon(IconBroken.Search),
          ),
        ),
        body: Column(
          children: [
            // MyTopWidget(color: questions, name: 'استفسارات',),
            MyQuestionWidget(),
          ],
        ),
      ),
    );
  }
}
