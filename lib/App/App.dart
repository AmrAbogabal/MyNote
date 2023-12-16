import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/Cubits/AppCubit/States.dart';
import 'package:note/Cubits/AppCubit/cubit.dart';
import 'package:note/Info/UserInfo.dart';

import 'package:note/test.dart';

class  App extends StatelessWidget {
  const  App({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<CubitOfMyApp, States>(
            listener: (context, state) => {},
            builder: (context, state) {
              var cubit = CubitOfMyApp.get(context) ;
              if(cubit.Data==false){
                cubit.GetUserData();
              }
              return Scaffold(
                  body:cubit.Loading==true?const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ):cubit.Pages[cubit.PageNumber],
                  //cubit.Pages[cubit.PageNumber],
                drawer: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
                  child: Drawer(
                    child: Test(),
                  ),),
              );
            }
        );
  }
  }

