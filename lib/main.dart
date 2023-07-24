import 'Authintication/cubit/cubit.dart';
import 'Authintication/login/login_screen.dart';
import 'blocObserver.dart';
import 'modules/addresses_screen/cubit/addresses_cubit.dart';
import 'modules/home_screen/new_home_screen.dart';
import 'modules/jobs_screen/cubit/jobs_cubit.dart';
import 'modules/news_screen/cubit/news_cubit.dart';
import 'modules/questions_screen/cubit/questions_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
          BlocProvider(
            create: (context) => NewsCubit(),
          ),
          BlocProvider(
            create: (context) => QuestionCubit(),
          ),
          BlocProvider(
            create: (context) => JobsCubit(),
          ),
          BlocProvider(
            create: (context) => AddressesCubit(),
          ),
        ],
        child: FirebaseAuth.instance.currentUser == null ? LoginScreen() : NewHomeScreen(),
      ),
      builder: EasyLoading.init(),
    );
  }
}

// FirebaseAuth.instance.currentUser == null ? LoginScreen() : NewHomeScreen()
