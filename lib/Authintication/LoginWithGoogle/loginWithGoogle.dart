// import 'package:algad_infohub/modules/home_screen/new_home_screen.dart';
// import 'package:algad_infohub/modules/news_screen/cubit/news_cubit.dart';
// import 'package:algad_infohub/shared/components/icon_broken.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import '../cubit/cubit.dart';
// import '../cubit/states.dart';
// import '../helpers/my_easyloading.dart';
//
// class GmailLoginScreen extends StatefulWidget {
//   @override
//   State<GmailLoginScreen> createState() => _GmailLoginScreenState();
// }
//
// class _GmailLoginScreenState extends State<GmailLoginScreen> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final ageController = TextEditingController();
//   final nationalityController = TextEditingController();
//   String selectedNationality = "سوريا";
//   final genderController = TextEditingController();
//   String selectedGender = "ذكر";
//
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return BlocListener<AuthCubit, AuthStates>(
//       listener: (context, state) {
//         if (state is LoginFailureState) {
//           showErrorMessage(state.errorMessage);
//           nameController.clear();
//           phoneController.clear();
//           return;
//         }
//         if (state is LoginSuccessState) {
//           showInfoMessage('أهلاً بك');
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => BlocProvider(
//                   create: (context) => NewsCubit(), child: NewHomeScreen()),
//             ),
//           );
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: Container(
//             width: double.infinity,
//             margin: EdgeInsets.all(size.width * .05),
//             child: Form(
//               key: formKey,
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.all(size.width * .03),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Image.asset(
//                         'images/login.png',
//                         width: size.width * .5,
//                         height: size.height * .25,
//                       ),
//                       SizedBox(
//                         height: size.height * .01,
//                       ),
//                       Text(
//                         "تسجيل الدخول",
//                         style: TextStyle(
//                           fontSize: size.width * .09,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.indigo,
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.height * .05,
//                       ),
//                       TextFormField(
//                         controller: nameController,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "الرجاء إدخال الإسم";
//                           }
//                           return null;
//                         },
//                         keyboardType: TextInputType.text,
//                         textInputAction: TextInputAction.next,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(IconBroken.Profile),
//                           labelText: 'الإسم الثلاثي',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.height * .01,
//                       ),
//                       TextFormField(
//                         keyboardType: TextInputType.phone,
//                         maxLength: 15,
//                         controller: phoneController,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "الرجاء إدخال رقم الهاتف";
//                           }
//                           if (value.length < 11) {
//                             return "الرجاء إدخال الرقم كاملاً";
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(IconBroken.Calling),
//                           hintText: "+201095787634",
//                           labelText: 'رقم الهاتف',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.height * .01,
//                       ),
//                       TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller: ageController,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "الرجاء إدخال العمر";
//                           }
//                           if (value.length < 2) {
//                             return "الرجاء إدخال العمر بشكل صحيح";
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(IconBroken.Calendar),
//                           hintText: "34",
//                           labelText: 'العمر',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.height * .01,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey.withOpacity(0),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: DropdownButton(
//                             items: [
//                               DropdownMenuItem(
//                                 child: Text("سوريا"),
//                                 value: 'سوريا',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("مصر"),
//                                 value: 'مصر',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("السودان"),
//                                 value: 'السودان',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("جنوب السودان"),
//                                 value: 'جنوب السودان',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("ارتيريا"),
//                                 value: 'ارتيريا',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("اثيوبيا"),
//                                 value: 'اثيوبيا',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("تونس"),
//                                 value: 'تونس',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("اليمن"),
//                                 value: 'اليمن',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("ليبيا"),
//                                 value: 'ليبيا',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("لبنان"),
//                                 value: 'لبنان',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("قطر"),
//                                 value: 'قطر',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("المملكة العربية السعودية"),
//                                 value: 'المملكة العربية السعودية',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("الكويت"),
//                                 value: 'الكويت',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("البحرين"),
//                                 value: 'البحرين',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("نيجيريا"),
//                                 value: 'نيجيريا',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("الجزائر"),
//                                 value: 'الجزائر',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("المغرب"),
//                                 value: 'المغرب',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("الاردن"),
//                                 value: 'الاردن',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("عمان"),
//                                 value: 'عمان',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("فلسطين"),
//                                 value: 'فلسطين',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("موريتانيا"),
//                                 value: 'موريتانيا',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("العراق"),
//                                 value: 'العراق',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("الصومال"),
//                                 value: 'الصومال',
//                               ),
//                             ],
//                             iconSize: size.width * .1,
//                             isExpanded: true,
//                             onChanged: (String? value) {
//                               setState(() {
//                                 selectedNationality = value!;
//                               });
//                             },
//                             value: selectedNationality,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.height * .01,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey.withOpacity(0),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: DropdownButton(
//                             items: [
//                               DropdownMenuItem(
//                                 child: Text("ذكر"),
//                                 value: 'ذكر',
//                               ),
//                               DropdownMenuItem(
//                                 child: Text("أنثى"),
//                                 value: 'أنثى',
//                               ),
//                             ],
//                             iconSize: size.width * .1,
//                             isExpanded: true,
//                             onChanged: (String? value) {
//                               setState(() {
//                                 selectedGender = value!;
//                               });
//                             },
//                             value: selectedGender,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.height * .01,
//                       ),
//                       Container(
//                         color: Colors.grey[200],
//                         width: double.infinity,
//                         child: TextButton(
//                           onPressed: () async {
//                             if (formKey.currentState!.validate()) {
//                               UserCredential? cred =
//                                   await AuthCubit.get(context)
//                                       .signInWithGoogle()
//                                       .then((value) {
//                                 AuthCubit.get(context).saveUserData(
//                                   auth.currentUser!,
//                                   username: auth.currentUser!.displayName,
//                                   email: auth.currentUser!.email,
//                                   phone: phoneController.text,
//                                   photoUrl: auth.currentUser!.photoURL,
//                                   nationality: selectedNationality,
//                                   gender: selectedGender,
//                                   name: nameController.text,
//                                   age: ageController.text,
//                                 );
//                               });
//                             }
//                           },
//                           child: Text(
//                             "تسجيل الدخول",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: size.width * .04,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }
