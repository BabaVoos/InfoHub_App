import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddAddressesScreen extends StatefulWidget {
  @override
  State<AddAddressesScreen> createState() => _AddAddressesScreenState();
}

class _AddAddressesScreenState extends State<AddAddressesScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var addressesController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfoHubCubit, InfoHubState>(
      listener: (context, state) {
        if (state is AddAddressesSuccessState) {
          Fluttertoast.showToast(
            msg: 'تم نشر المحتوى بنجاح',
            backgroundColor: adminColor,
            fontSize: 30,
            textColor: Colors.white,
            timeInSecForIosWeb: 2,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );
          nameController.clear();
          addressesController.clear();
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text('رجوع',),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: nameController,
                      textInputAction: TextInputAction.newline,
                      maxLines: 5,
                      minLines: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'اسم الجهة',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرجاء إدخال اسم الجهة";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: addressesController,
                      textInputAction: TextInputAction.newline,
                      maxLines: 100,
                      minLines: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'العناوين',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرجاء إدخال العناوين";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(formKey.currentState!.validate()) {
                          InfoHubCubit.get(context).AddressesCreate(
                            name: nameController.text,
                            addresses: addressesController.text,
                            date: FieldValue.serverTimestamp(),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Add',
                          style: TextStyle(fontSize: 30),
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
