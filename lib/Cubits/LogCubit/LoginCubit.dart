
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note/Cubits/LogCubit/LoginStates.dart';
import 'package:note/Info/UserInfo.dart';
import 'dart:io';
import 'package:email_auth/email_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../App/App.dart';
import '../../Cash/shared.dart';
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(AppInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
 late final SharedPreferences prefs;
   File profileImage = File("");
   bool SelectImage =  false ;
   bool isloading = false ;
   String? Vcode ;
  var picker = ImagePicker();
  EmailAuth emailAuth = new EmailAuth(sessionName: "Sample session");
  void SignUp(String Email, String Password, String Image,name,context) {
    emit(SignUpLoading());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: Email, password: Password).then((value){
      StorUserData(name ,Image,value.user!.uid,context,Email,Password);
    }).catchError((e){
      Fluttertoast.showToast(
          msg:e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }
  void SignIn(String Email, String Password,context) {
    emit(SignInLoading());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: Email, password: Password).then((
        value) async{
      print(value.toString());
      USER_ID = value.user!.uid ;
      await CacheHelper.putString(key: 'UserId', value: value.user!.uid);
      await CacheHelper.putBoolean(key: 'LogState', value: true);
      LogState = true ;
      print("Dooooooooooooooooooooooooooooooooooooooood");
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) =>  App()),
        ModalRoute.withName('/'),
      );
      Fluttertoast.showToast(
          msg:"Sign In Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emit(SignInSuccess());
    }).catchError((e) {
      print("Not Dooooooooooooooooooooooooooooooooooooooood");
      print(e.toString());
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emit(SignInError());
    });
  }
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
      SelectImage = true ;
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }
  void uploadProfileImage(Email , Password,name ,context) {
    emit(uploadProfileImageLoadingState());
    isloading = true ;
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage.path)
        .pathSegments
        .last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadProfileImageSuccessState());
        print(value);
        print("Start");
        SignUp(Email ,Password,value.toString(),name,context);
      }).catchError((error) {
        Fluttertoast.showToast(
            msg: error.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emit(UploadProfileImageErrorState());
    });
  }
  void StorUserData(name ,urlimage,uid,context,Email,password) {
    emit(StoreUserLoading());
    FirebaseFirestore.instance
        .collection(uid).doc(info)
        .set({
       "Name" :name,
       "ImageUrl" :urlimage,
       "Uid" :uid,
    }
    )
        .then((value)  async {
          isloading = false ;
     await Fluttertoast.showToast(
          msg: "Sign Up Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
          SignIn(Email,password,context) ;
      emit(StoreUserSuccessState());
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emit(StoreUserErrorState());
    });
  }
  void PremissionHandler()async{
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }

    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    print(statuses[Permission.location]);
  }
}
