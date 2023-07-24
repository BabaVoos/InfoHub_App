import 'package:algad_infohub/Authintication/register/register_screen.dart';
import 'package:algad_infohub/modules/home_screen/new_home_screen.dart';
import 'package:algad_infohub/modules/news_screen/cubit/news_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../helpers/my_easyloading.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginFailureState) {
          showErrorMessage(state.errorMessage);
          emailController.clear();
          passwordController.clear();
          return;
        }
        if (state is LoginSuccessState) {
          showInfoMessage('أهلاً بك');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => NewsCubit(),
                child: NewHomeScreen(),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                    const Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرجاء إدخال اسم المستخدم";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                          color: mainColor,
                        ),
                        hintText: "اسم المستخدم",
                        hintStyle: const TextStyle(color: mainColor),
                        labelText: 'اسم المستخدم',
                        labelStyle: const TextStyle(
                          color: mainColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          borderSide: const BorderSide(
                            color: mainColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: mainColor,
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرجاء إدخال كلمة المرور";
                        }
                        if (value.length < 6) {
                          return "كلمة مرور ضعيفة";
                        }
                        return null;
                      },
                      obscureText: AuthCubit.get(context).isPasswordShown,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock,color: mainColor,),
                        suffixIcon: IconButton(
                          onPressed: () {
                            AuthCubit.get(context).changePasswordVisibility();
                            setState(() {});
                          },
                          icon: Icon(
                            AuthCubit.get(context).isPasswordShown
                                ? Icons.visibility_off
                                : Icons.visibility,color: mainColor,
                          ),
                        ),
                        hintText: "كلمة المرور",
                        hintStyle: TextStyle(color: mainColor,),
                        labelText: 'كلمة المرور',
                        labelStyle: TextStyle(color: mainColor),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor,),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor,),
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                      ),
                    ),),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      color: mainColor,
                      child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            login();
                          } else {
                            print('Not Valid');
                          }
                        },
                        child: const Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: this.context.read<AuthCubit>(),
                                    child: RegisterScreen(),
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'إنشاء حساب؟',
                              style: TextStyle(
                                fontSize: 20,
                                color: mainColor,
                              ),
                            )),
                      ],
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

  void login() {
    showLoading();

    String email = "${emailController.text}@infohub.com";
    String password = passwordController.text;

    context.read<AuthCubit>().login(email: email, password: password);
  }
}
