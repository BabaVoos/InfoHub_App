import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddNewsScreen extends StatefulWidget {
  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var newsController = TextEditingController();
  var nameController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfoHubCubit, InfoHubState>(
      listener: (context, state) {
        if (state is AddNewsSuccessState) {
          Fluttertoast.showToast(
            msg: 'تم نشر الخبر بنجاح',
            backgroundColor: adminColor,
            fontSize: 30,
            textColor: Colors.white,
            timeInSecForIosWeb: 2,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );
          // InfoHubCubit.get(context).showNotification(nameController.text, newsController.text);
          nameController.clear();
          newsController.clear();
          dateController.clear();
        }
      },
      builder: (context, state) {
        var size = MediaQuery.of(context).size;
        return Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(size.width * .05),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: newsController,
                      textInputAction: TextInputAction.newline,
                      maxLines: 80,
                      minLines: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'الرجاء إضافة الخبر المراد نشره',
                        hintStyle: TextStyle(
                          fontSize: size.width * .05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرجاء إدخال الخبر";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    TextFormField(
                      controller: nameController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'الرجاء إضافة اسم الجهة الصادر منها الخبر',
                        hintStyle: TextStyle(
                          fontSize: size.width * .05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرجاء إدخال اسم الجهة الناشرة";
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
                          dateController.text =
                              DateFormat.yMMMd().format(value!);
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
                          InfoHubCubit.get(context).newCreate(
                            news: newsController.text,
                            name: nameController.text,
                            date: dateController.text,
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
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
          ),
        );
      },
    );
  }
}
