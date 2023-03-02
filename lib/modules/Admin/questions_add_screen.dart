import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddQuestionsScreen extends StatefulWidget {
  @override
  State<AddQuestionsScreen> createState() => _AddQuestionsScreenState();
}

class _AddQuestionsScreenState extends State<AddQuestionsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var questionController = TextEditingController();
  var answerController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfoHubCubit, InfoHubState>(
      listener: (context, state) {
        if (state is AddQuestionsSuccessState) {
          Fluttertoast.showToast(
            msg: 'تم نشر السؤال بنجاح',
            backgroundColor: adminColor,
            fontSize: 30,
            textColor: Colors.white,
            timeInSecForIosWeb: 2,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );
          questionController.clear();
          answerController.clear();
          dateController.clear();
        }
      },
      builder: (context, state) {
        var size = MediaQuery.of(context).size;
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(size.width * .05),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  TextFormField(
                    maxLines: 40,
                    minLines: 2,
                    controller: questionController,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'اكتب سؤالك هنا',
                      hintStyle: TextStyle(
                        fontSize: size.width * .05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء إدخال السؤال";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  TextFormField(
                    controller: answerController,
                    maxLines: 80,
                    minLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'اكتب اجابتك هنا',
                      hintStyle: TextStyle(
                        fontSize: size.width * .05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء إدخال الإجابة";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  TextFormField(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        dateController.text = DateFormat.yMMMd().format(value!);
                      });
                    },
                    controller: dateController,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.datetime,
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: ' التاريخ',
                      hintStyle: TextStyle(
                        fontSize: size.width * .05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء إدخال التاريخ";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        InfoHubCubit.get(context).questionCreate(
                          question: questionController.text,
                          answer: answerController.text,
                          date: dateController.text,
                        );
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(size.width * .04),
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontSize: size.width * .08,
                          fontWeight: FontWeight.bold,
                        ),
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
