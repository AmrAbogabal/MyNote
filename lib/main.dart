import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note/App/App.dart';
import 'package:note/App/Edit.dart';
import 'package:note/Cubits/AppCubit/States.dart';
import 'package:note/Cubits/AppCubit/cubit.dart';
import 'package:note/Theme/Theme.dart';
import 'package:note/firebase_options.dart';

import 'Cash/shared.dart';
import 'Onboarding.dart';
import 'test.dart';

void main() async {
 await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => CubitOfMyApp() ,
        child: BlocConsumer<CubitOfMyApp, States>(
            listener: (context, state) => {},
            builder: (context, state) {
              var cubit = CubitOfMyApp.get(context) ;
              print("amr");
              return MaterialApp(
                title: 'Flutter Demo',
                builder: FToastBuilder(),
                themeMode:cubit.dark?ThemeMode.dark:ThemeMode.light,
                theme: MyThemes.lightTheme,
                darkTheme: MyThemes.darkTheme,

                home:  CacheHelper.getBoolean(key:"LogState")==true?App():Onboarding(),
              );
            }
        )
    );
  }
}

