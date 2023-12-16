
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note/App/Add.dart';
import 'package:note/App/Edit.dart';
import 'package:note/App/Home.dart';
import 'package:note/Cubits/AppCubit/States.dart';
import 'package:note/Info/UserInfo.dart';
import 'package:note/Models/TaskModel.dart';
import 'package:note/Models/User.dart';
import '../../Cash/shared.dart';
import '../../test.dart';
class CubitOfMyApp extends Cubit<States> {
  CubitOfMyApp() : super(AppInitialState());
  static CubitOfMyApp get(context) => BlocProvider.of(context);
  int ItemSelected = 0 ;
  int PageNumber = 0 ;
  bool dark = false ;
  bool Loading = false ;
  bool Data = false ;
   UserModel? user;
  bool TasksData = false ;
  List<String> Sections =[];
  List<List<TaskModel>> AllTasks =[];
  late dynamic M ;
  late TaskModel Tes ;
  int TaskS = 0;
late  File profileImage = File("");
  var picker = ImagePicker();
  final firestoreInstance = FirebaseFirestore.instance;
  void pr(){
    print("444444444444444444444444444444");
    print(Sections.length);
    print(AllTasks.length);
    Sections.forEach((element) {
      print(element);
    });
    AllTasks.forEach((element) {
      element.forEach((element) {
        print(element.Title) ;
      });
      print("£££££££££££££££££££££££££££££££££££££££££");
    });
  }
  Future<void> GetUserData() async{
    print("Start");
    Loading = true ;
    USER_ID = CacheHelper.getString(key: "UserId")!;
    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<object>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    print(USER_ID);
    await FirebaseFirestore.instance.collection(USER_ID).doc(info).get().then((v) {
      if (v.exists) {
        print("In Get >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        Object? data = v.data();
        user = UserModel.fromJson(v.data()!);
        print(user!.name);
        print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
      } else {
        print('المستند غير موجود');
      }
    });
    Loading = false ;
    Data = true ;
    emit(GetUserDataState());
  }
  Future<void> AddSections(String s)async {
    FirebaseFirestore.instance.collection(USER_ID).doc(s).set({}) ;
   await FirebaseFirestore.instance.collection(USER_ID).doc("SectionsName").collection("Names").doc(s).set({
   }) ;
    print("Add Section ${s}");
    TasksData = false ;
  }
  Future<void> GetSections()async {
    Sections=[] ;
    AllTasks=[];
   await FirebaseFirestore.instance.collection(USER_ID).doc("SectionsName").collection("Names").get().then((value){
     value.docs.forEach((elementS) {
       Sections.add(elementS.id);
       firestoreInstance.collection(USER_ID).doc(elementS.id).collection("Tasks").get().then((value){
         if(value.docs.length>0){
           List<TaskModel> t = [];
           value.docs.forEach((element) {
             print(value.docs.length);
             print(element.data());
             print("xx");
             t.add(TaskModel.fromJson(element.data()));
           });
           AllTasks.add(t);
           emit(GetTasksSuccess());
         }else{
           List<TaskModel> s = [];
           AllTasks.add(s);
           emit(GetTasksSuccess());
         }
       }) ;
     });
     TasksData  = true ;
     emit(GetSSuccess());
   }).catchError((e){
     emit(GetSError());

   });
    emit(RefreshState());
  }
  Future<void> GetTasks() async {
    print("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCc");
    //await GetSections();
    AllTasks=[];
    Sections = [] ;
    final firestoreInstance = FirebaseFirestore.instance;
    await FirebaseFirestore.instance.collection(USER_ID).doc("SectionsName").collection("Names").get().then((value) {
      value.docs.forEach((elementS) {
        Sections.add(elementS.id);
        print("object ${elementS.id}") ;
      });
    });
    print("***********************************************************************************************");
    Sections.forEach((elementS) async {
      print(elementS);
      await firestoreInstance.collection(USER_ID).doc(elementS).collection("Tasks").get().then((value){
        if(value.docs.length>0){
          List<TaskModel> t = [] ;
          value.docs.forEach((element) {
            print(value.docs.length);
            print(element.data());
            print("xx");
            t.add(TaskModel.fromJson(element.data()));
          });
          AllTasks.add(t);
          emit(GetTasksSuccess());
        }else{
          List<TaskModel> s = [];
          AllTasks.add(s);
          emit(GetTasksSuccess());
        }
        print(elementS);
        value.docs.forEach((element) {
          print(element.data());
        });
      }) ;
    });
    print("**************************************************************************************************");

    emit(GetTasksSuccess());
    TasksData  = true ;
  }
  Future<void> EditSections(String T ,String S)async {
    FirebaseFirestore.instance.collection(USER_ID).doc(Sections[0]).collection("Sections").doc(M.Id).set(
        {
          "Title": T,
          "Subject": S,
          "Date": DateTime.now(),
          "Id": M.Id,
        }
    ).then((value){}).catchError((e){
    }) ;
    TasksData = false ;
  }
  Future<void> AddTaskInSections(String s ,String T,String S ,DateTime Ti )async {
    Random objectname = Random();
    int number = objectname.nextInt(1000000000);
    FirebaseFirestore.instance.collection(USER_ID).doc(s).collection("Tasks").doc("${number}").set(
        {
          "Title": T,
          "Subject": S,
          "Date": Ti,
          "Id": "${number}",
        }
    ).then((value){}).catchError((e){
    });
    TasksData = false ;
  }
  void ChangeItemSelected(int i ){
    ItemSelected = i ;
    emit(ChangeItemSelectedState()) ;
  }
  void ChangePage(int i ){
    PageNumber = i ;
    emit(ChangePageState()) ;
  }
  List<Widget> Pages = [HomeP(),Add(),Edit(),] ;
  void ChangeMode(v){
    dark = v ;
    emit(ChangeModeState());
  }
  void Refresh(){
    Data = false ;
    TasksData = false ;
    emit(RefreshState());
  }
  void LogOut(){
    FirebaseAuth.instance.signOut();
    CacheHelper.putString(key: "UserId", value: "") ;
    CacheHelper.putBoolean(key: "LogState", value: false) ;
    Data = false ;
  }
  void ChangeUserName(String name){
    FirebaseFirestore.instance.collection(USER_ID).doc("3V5xB272YhsE4pjfBbrJ").set({
      "Name": name,
      "ImageUrl": user!.image,
      "Uid": user!.uId,
    }).then((value){
      Data = false ;
      emit(ChangeUserNameState());
    }).catchError((e){

    });
    emit(ChangeUserNameError());
  }
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      FirebaseStorage.instance
          .ref()
          .child('users/${Uri
          .file(profileImage.path)
          .pathSegments
          .last}')
          .putFile(profileImage).then((p0) {
        FirebaseFirestore.instance.collection(USER_ID).doc("3V5xB272YhsE4pjfBbrJ").set({
          "Name": user!.name,
          "ImageUrl": profileImage,
          "Uid": user!.uId,
        }).then((value){
          Data = false ;
          emit(ChangeUserNameState());
        }).catchError((e){

        });
        emit(ChangeUserNameError());
      }).catchError((e){
            print(e.toString());
      });
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }
  }
