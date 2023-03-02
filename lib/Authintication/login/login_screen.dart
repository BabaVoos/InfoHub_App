import 'package:algad_infohub/Authintication/register/register_screen.dart';
import 'package:algad_infohub/modules/home_screen/home_screen.dart';
import 'package:algad_infohub/modules/splash_screen/splash_screen.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  create: (context) => InfoHubCubit(), child: HomeScreen()),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'images/login.png',
                      width: size.width * .6,
                      height: size.height * .25,
                    ),
                    SizedBox(
                      height: size.height * .1,
                    ),
                    Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    SizedBox(
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
                        prefixIcon: Icon(Icons.email),
                        hintText: "اسم المستخدم",
                        labelText: 'اسم المستخدم',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
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
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            AuthCubit.get(context).changePasswordVisibility();
                            setState((){});
                          },
                          icon: Icon(
                            AuthCubit.get(context).isPasswordShown
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        hintText: "كلمة المرور",
                        labelText: 'كلمة المرور',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                login();
                              } else {
                                print('Not Valid');
                              }
                            },
                            child: Text('تسجيل الدخول'),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
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
                            child: Text(
                              'إنشاء حساب؟',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.indigo,
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
