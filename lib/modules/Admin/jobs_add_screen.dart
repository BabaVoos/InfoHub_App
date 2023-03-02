import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddJobsScreen extends StatefulWidget {
  @override
  State<AddJobsScreen> createState() => _AddJobsScreenState();
}

class _AddJobsScreenState extends State<AddJobsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var jobController = TextEditingController();
  var dateController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfoHubCubit, InfoHubState>(
      listener: (context, state) {
        if (state is AddJobsSuccessState) {
          Fluttertoast.showToast(
            msg: 'تم نشر اعلان الوظيفة بنجاح',
            backgroundColor: adminColor,
            fontSize: 30,
            textColor: Colors.white,
            timeInSecForIosWeb: 2,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );
          jobController.clear();
          nameController.clear();
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
                    controller: nameController,
                    textInputAction: TextInputAction.newline,
                    maxLines: 2,
                    minLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'المسمى الوظيفي',
                      hintStyle: TextStyle(
                        fontSize: size.width * .05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء إدخال المسمى الوظيفي";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  TextFormField(
                    controller: jobController,
                    textInputAction: TextInputAction.newline,
                    maxLines: 40,
                    minLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: ' الوظيفة المتاحة',
                      hintStyle: TextStyle(
                        fontSize: size.width * .05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء إدخال الوظيفة";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * .02,
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
                        InfoHubCubit.get(context).jobsCreate(
                          job: jobController.text,
                          date: dateController.text,
                          name: nameController.text,
                        );
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(size.width * .03),
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
