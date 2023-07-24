import 'package:algad_infohub/Authintication/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  var firebaseAuth = FirebaseAuth.instance;

  void createAccount({
    required String email,
    required String password,
    required String username,
    required String gender,
    required String phone,
    required String nationality,
  }) {
    firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await FirebaseMessaging.instance.subscribeToTopic('notify');
      saveUserData(
        value.user!,
        username: username,
        email: email,
        gender: gender,
        phone: phone,
        nationality: nationality,
        name: null,
        age: null,
      );
    }).catchError((error) => emit(RegisterFailureState(error.toString())));
  }

  void login({
    required String email,
    required String password,
  }) {
    firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
          (value) async {
            await FirebaseMessaging.instance.subscribeToTopic('notify');
            emit(
              LoginSuccessState(),
            );
          }
        )
        .catchError(
          (error) => emit(
            LoginFailureState(
              error,
            ),
          ),
        );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser!.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //
  //   emit(LoginSuccessState());
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  // Future signInWithGoogle2() async {
  //   GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //   GoogleSignInAuthentication? googleSignInAuthentication =
  //       await googleSignInAccount!.authentication;
  //   AuthCredential authCredential = GoogleAuthProvider.credential(
  //     idToken: googleSignInAuthentication.idToken,
  //     accessToken: googleSignInAuthentication.accessToken,
  //   );
  //   emit(LoginSuccessState());
  // }

  void saveUserData(
    User user, {
    required username,
    required name,
    required age,
    required email,
    required gender,
    required phone,
    required nationality,
    String? photoUrl,
  }) {
    FirebaseFirestore.instance.collection('myUsers').doc(user.uid).set({
      "username": auth.currentUser!.displayName,
      'name': name,
      "email": auth.currentUser!.email,
      "gender": gender,
      "phone": phone,
      "nationality": nationality,
      "photoUel": auth.currentUser!.photoURL,
    }).then(
      (value) async {
        await FirebaseMessaging.instance.subscribeToTopic('notify');
        emit(
          LoginSuccessState(),
        );
      } 
    );
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
