import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/conponents.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsDetailsScreen extends StatelessWidget {
  const QuestionsDetailsScreen({
    Key? key,
    required this.question,
    required this.answer,
    required this.date,
  }) : super(key: key);

  final String question;
  final String answer;
  final String date;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<InfoHubCubit, InfoHubState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "رجوع",
                ),
                backgroundColor: questions,
                elevation: 0,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(size.width * .05),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/oo.png'),
                        ),
                      ),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Text(
                            question,
                            style: TextStyle(
                              fontSize: size.width * .05,
                              height: size.height * .0017,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * .2,
                              vertical: size.height * .02,
                            ),
                            child: Divider(
                              color: questions,
                              thickness: 5,
                            ),
                          ),
                          Text(
                            answer,
                            style: TextStyle(
                              fontSize: size.width * .05,
                              height: size.height * .002,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

