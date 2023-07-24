import 'package:algad_infohub/Authintication/cubit/cubit.dart';
import 'package:algad_infohub/Authintication/cubit/states.dart';
import 'package:algad_infohub/Authintication/helpers/my_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/colors.dart';

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
          title: const Text(
            "إنشاء حساب",
          ),
          backgroundColor: mainColor,
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(
              20,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Container(
                      width: double.infinity,
                      height: size.height * .3,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: mainColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'images/login.jpg',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                        prefixIcon: const Icon(
                          Icons.email,
                          color: mainColor,
                        ),
                        hintText: "john / jonh_653",
                        hintStyle: const TextStyle(
                          color: mainColor,
                        ),
                        labelStyle: const TextStyle(
                          color: mainColor,
                        ),
                        labelText: 'اسم المستخدم باللغة الإنجليزية',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          borderSide: const BorderSide(
                            color: mainColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          borderSide: const BorderSide(
                            color: mainColor,
                          ),
                        ),
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
                      obscureText: AuthCubit.get(context).isPasswordShown,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: mainColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            AuthCubit.get(context).changePasswordVisibility();
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: mainColor,
                          ),
                        ),
                        hintText: "كلمة المرور",
                        hintStyle: const TextStyle(
                          color: mainColor,
                        ),
                        labelStyle: const TextStyle(
                          color: mainColor,
                        ),
                        labelText: 'كلمة المرور',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            borderSide: const BorderSide(
                              color: mainColor,
                            )),
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
                        prefixIcon: const Icon(
                          Icons.person,
                          color: mainColor,
                        ),
                        hintText: "الاسم الثلاثي",
                        hintStyle: const TextStyle(
                          color: mainColor,
                        ),
                        labelStyle: const TextStyle(
                          color: mainColor,
                        ),
                        labelText: 'الاسم الثلاثي',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          borderSide: const BorderSide(
                            color: mainColor,
                          ),
                        ),
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
                      decoration:  InputDecoration(
                        prefixIcon: const Icon(Icons.email,color: mainColor,),
                        hintText: "01000000000",
                        hintStyle: const TextStyle(color: mainColor,),
                        labelStyle: const TextStyle(color: mainColor,),
                        labelText: 'رقم الهاتف',
                        border:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10,),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10,),
                          borderSide: const BorderSide(color: mainColor,)
                        ),
                      ),
                      maxLength: 11,
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10,),
                        border: Border.all(
                          color: mainColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0,),
                        child: DropdownButton(
                          items: const [
                            DropdownMenuItem(
                              value: 'ذكر',
                              child: Text("ذكر",),
                            ),
                            DropdownMenuItem(
                              value: 'أنثى',
                              child: Text("أنثى"),
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
                        borderRadius: BorderRadius.circular(10,),
                        border: Border.all(
                          color: mainColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          items: const [
                            DropdownMenuItem(
                              value: 'سوريا',
                              child: Text("سوريا"),
                            ),
                            DropdownMenuItem(
                              value: 'مصر',
                              child: Text("مصر"),
                            ),
                            DropdownMenuItem(
                              value: 'السودان',
                              child: Text("السودان"),
                            ),
                            DropdownMenuItem(
                              value: 'جنوب السودان',
                              child: Text("جنوب السودان"),
                            ),
                            DropdownMenuItem(
                              value: 'ارتيريا',
                              child: Text("ارتيريا"),
                            ),
                            DropdownMenuItem(
                              value: 'اثيوبيا',
                              child: Text("اثيوبيا"),
                            ),
                            DropdownMenuItem(
                              value: 'تونس',
                              child: Text("تونس"),
                            ),
                            DropdownMenuItem(
                              value: 'اليمن',
                              child: Text("اليمن"),
                            ),
                            DropdownMenuItem(
                              value: 'ليبيا',
                              child: Text("ليبيا"),
                            ),
                            DropdownMenuItem(
                              value: 'لبنان',
                              child: Text("لبنان"),
                            ),
                            DropdownMenuItem(
                              value: 'قطر',
                              child: Text("قطر"),
                            ),
                            DropdownMenuItem(
                              value: 'المملكة العربية السعودية',
                              child: Text("المملكة العربية السعودية"),
                            ),
                            DropdownMenuItem(
                              value: 'الكويت',
                              child: Text("الكويت"),
                            ),
                            DropdownMenuItem(
                              value: 'البحرين',
                              child: Text("البحرين"),
                            ),
                            DropdownMenuItem(
                              value: 'نيجيريا',
                              child: Text("نيجيريا"),
                            ),
                            DropdownMenuItem(
                              value: 'الجزائر',
                              child: Text("الجزائر"),
                            ),
                            DropdownMenuItem(
                              value: 'المغرب',
                              child: Text("المغرب"),
                            ),
                            DropdownMenuItem(
                              value: 'الاردن',
                              child: Text("الاردن"),
                            ),
                            DropdownMenuItem(
                              value: 'عمان',
                              child: Text("عمان"),
                            ),
                            DropdownMenuItem(
                              value: 'فلسطين',
                              child: Text("فلسطين"),
                            ),
                            DropdownMenuItem(
                              value: 'موريتانيا',
                              child: Text("موريتانيا"),
                            ),
                            DropdownMenuItem(
                              value: 'العراق',
                              child: Text("العراق"),
                            ),
                            DropdownMenuItem(
                              value: 'الصومال',
                              child: Text("الصومال"),
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
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10,),
                        color: mainColor,
                      ),
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            register();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(size.width * .02),
                          child: Text(
                            "إنشاء حساب",
                            style: TextStyle(
                              fontSize: size.width * .05,
                              color: backgroundColor,
                              fontWeight: FontWeight.bold,
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
