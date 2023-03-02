import 'package:algad_infohub/Authintication/cubit/cubit.dart';
import 'package:algad_infohub/Authintication/cubit/states.dart';
import 'package:algad_infohub/Authintication/helpers/my_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscureText = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final nationalityController = TextEditingController();
  String selectedGender = "ذكر";
  String selectedNationality = "سوريا";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        stopLoading();
        if (state is RegisterFailureState) {
          showErrorMessage(state.errorMessage);
          return;
        }
        if (state is RegisterSuccessState) {
          showSuccessMessage('Account created!');
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "إنشاء حساب",
          ),
          backgroundColor: Colors.indigo,
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * .01,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرجاء إدخال البريد الإلكتروني";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "john",
                        labelText: 'اسم المستخدم باللغة الإنجليزية',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرجاء إدحال كلمة المرور";
                        }
                        if (value.length < 6) {
                          return "كلمة مرور ضعيفة";
                        }
                        return null;
                      },
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            obscureText = !obscureText;
                            setState(() {});
                          },
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        hintText: "كلمة المرور",
                        labelText: 'كلمة المرور',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    TextFormField(
                      controller: userNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرجاء ادخال اسمك";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "الاسم الثلاثي",
                        labelText: 'الاسم الثلاثي',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    TextFormField(
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرجاء ادخال رقم الهاتف";
                        }
                        if (value.length < 11) {
                          return "الرقم غير صحيح";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "01094284163",
                        labelText: 'رقم الهاتف',
                        border: OutlineInputBorder(),
                      ),
                      maxLength: 11,
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    // TextFormField(
                    //   controller: genderController,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "الرجاء ادخال الجنس";
                    //     }
                    //     return null;
                    //   },
                    //   keyboardType: TextInputType.name,
                    //   textInputAction: TextInputAction.send,
                    //   decoration: InputDecoration(
                    //     prefixIcon: Icon(Icons.female),
                    //     hintText: "ذكر - أنثى",
                    //     labelText: 'الجنس',
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   controller: nationalityController,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "الرجاء ادخال جنسية المستخدم";
                    //     }
                    //     return null;
                    //   },
                    //   keyboardType: TextInputType.name,
                    //   textInputAction: TextInputAction.send,
                    //   decoration: InputDecoration(
                    //     prefixIcon: Icon(Icons.female),
                    //     hintText: "سوري",
                    //     labelText: 'الجنسية',
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(.7),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          items: [
                            DropdownMenuItem(
                              child: Text("ذكر"),
                              value: 'ذكر',
                            ),
                            DropdownMenuItem(
                              child: Text("أنثى"),
                              value: 'أنثى',
                            ),
                          ],
                          iconSize: size.width * .1,
                          isExpanded: true,
                          onChanged: (String? value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                          value: selectedGender,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(.8),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          items: [
                            DropdownMenuItem(
                              child: Text("سوريا"),
                              value: 'سوريا',
                            ),
                            DropdownMenuItem(
                              child: Text("مصر"),
                              value: 'مصر',
                            ),
                            DropdownMenuItem(
                              child: Text("السودان"),
                              value: 'السودان',
                            ),
                            DropdownMenuItem(
                              child: Text("جنوب السودان"),
                              value: 'جنوب السودان',
                            ),
                            DropdownMenuItem(
                              child: Text("ارتيريا"),
                              value: 'ارتيريا',
                            ),
                            DropdownMenuItem(
                              child: Text("اثيوبيا"),
                              value: 'اثيوبيا',
                            ),
                            DropdownMenuItem(
                              child: Text("تونس"),
                              value: 'تونس',
                            ),
                            DropdownMenuItem(
                              child: Text("اليمن"),
                              value: 'اليمن',
                            ),
                            DropdownMenuItem(
                              child: Text("ليبيا"),
                              value: 'ليبيا',
                            ),
                            DropdownMenuItem(
                              child: Text("لبنان"),
                              value: 'لبنان',
                            ),
                            DropdownMenuItem(
                              child: Text("قطر"),
                              value: 'قطر',
                            ),
                            DropdownMenuItem(
                              child: Text("المملكة العربية السعودية"),
                              value: 'المملكة العربية السعودية',
                            ),
                            DropdownMenuItem(
                              child: Text("الكويت"),
                              value: 'الكويت',
                            ),
                            DropdownMenuItem(
                              child: Text("البحرين"),
                              value: 'البحرين',
                            ),
                            DropdownMenuItem(
                              child: Text("نيجيريا"),
                              value: 'نيجيريا',
                            ),
                            DropdownMenuItem(
                              child: Text("الجزائر"),
                              value: 'الجزائر',
                            ),
                            DropdownMenuItem(
                              child: Text("المغرب"),
                              value: 'المغرب',
                            ),
                            DropdownMenuItem(
                              child: Text("الاردن"),
                              value: 'الاردن',
                            ),
                            DropdownMenuItem(
                              child: Text("عمان"),
                              value: 'عمان',
                            ),
                            DropdownMenuItem(
                              child: Text("فلسطين"),
                              value: 'فلسطين',
                            ),
                            DropdownMenuItem(
                              child: Text("موريتانيا"),
                              value: 'موريتانيا',
                            ),
                            DropdownMenuItem(
                              child: Text("العراق"),
                              value: 'العراق',
                            ),
                            DropdownMenuItem(
                              child: Text("الصومال"),
                              value: 'الصومال',
                            ),
                          ],
                          iconSize: size.width * .1,
                          isExpanded: true,
                          onChanged: (String? value) {
                            setState(() {
                              selectedNationality = value!;
                            });
                          },
                          value: selectedNationality,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            register();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(size.width * .04),
                          child: Text(
                            "إنشاء حساب",
                            style: TextStyle(
                              fontSize: size.width * .07,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    showLoading();
    String email = "${emailController.text}@infohub.com";
    String password = passwordController.text;

    context.read<AuthCubit>().createAccount(
          email: email,
          password: password,
          username: userNameController.text,
          phone: phoneController.text,
          gender: selectedGender,
          nationality: selectedNationality,
        );

    emailController.clear();
    passwordController.clear();
  }

}
