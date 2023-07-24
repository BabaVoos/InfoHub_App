import 'package:algad_infohub/modules/questions_screen/cubit/questions_cubit.dart';
import 'package:algad_infohub/modules/questions_screen/cubit/questions_states.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/my_top_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class QuestionsDetailsScreen extends StatelessWidget {
  const QuestionsDetailsScreen({
    Key? key,
    required this.question,
    required this.answer,
    required this.date,
    required this.id,
  }) : super(key: key);

  final String id;
  final String question;
  final String answer;
  final String date;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<QuestionCubit, QuestionStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "رجوع",
              ),
              backgroundColor: mainColor,
              elevation: 0,
            ),
            body: Column(
              children: [
                MyTopWidget(
                  color: mainColor,
                  name: question,
                  id: id,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(size.width * .05),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/oo.png'),
                      ),
                    ),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Linkify(
                          text: answer,
                          style: TextStyle(
                            fontSize: size.width * .05,
                            height: size.height * .002,
                            fontWeight: FontWeight.w500,
                          ),
                          onOpen: _onOpen,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await launch(link.url)) {
      await canLaunch(link.url);
    } else {}
  }
}
