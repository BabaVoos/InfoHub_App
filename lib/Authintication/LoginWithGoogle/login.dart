// import 'package:algad_infohub/Authintication/LoginWithGoogle/saveData.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import '../cubit/cubit.dart';
// // import '../cubit/states.dart';
// import '../helpers/my_easyloading.dart';
//
// class LoginMainScreen extends StatelessWidget {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return BlocConsumer<AuthCubit, AuthStates>(
//       listener: (context, state) {
//         if (state is LoginFailureState) {
//           showErrorMessage(state.errorMessage);
//           return;
//         }
//         if (state is LoginSuccessState) {
//           showInfoMessage('أهلاً بك');
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => BlocProvider(
//                   create: (context) => AuthCubit(), child: SaveMyUserData(),),
//             ),
//           );
//         }
//       },
//       builder: (context,state) {
//         return Scaffold(
//           backgroundColor: Colors.white,
//           body: SafeArea(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: size.width * .1),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'images/login.png',
//                     width: size.width * 1,
//                     height: size.height * .25,
//                   ),
//                   SizedBox(
//                     height: size.height * .05,
//                   ),
//                   Container(
//                     height: size.height * .07,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       border: Border.all(color: Colors.black)
//                     ),
//                     child: TextButton(
//                       onPressed: () async {
//                         UserCredential? cred =
//                         await AuthCubit.get(context).signInWithGoogle();
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             " Google الاستمرار من خلال ",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: size.width * .04,
//                             ),
//                           ),
//                           SizedBox(width: 10,),
//                           Image.asset('images/google.png',width: size.width * .09,),
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
