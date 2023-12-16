
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:note/Cubits/LogCubit/LoginCubit.dart';
import 'package:note/Cubits/LogCubit/LoginStates.dart';

import 'App/App.dart';
class  LogScreen extends StatefulWidget {
  const  LogScreen({super.key});
  @override
  State<LogScreen> createState() => _HomePState();
}
class _HomePState extends State<LogScreen> {
  bool l = false ;
  FirebaseAuth auth = FirebaseAuth.instance;
  final formKeyL = GlobalKey<FormState>();
  final formKeyS = GlobalKey<FormState>();
  var Email = TextEditingController();
  var Name = TextEditingController();
  var Password = TextEditingController();
  var EmailS = TextEditingController();
  var PasswordS = TextEditingController();
  var PasswordSC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double h =  MediaQuery.of(context).size.height ;
    double hh =  MediaQuery.of(context).size.height/2 ;
    double w =  MediaQuery.of(context).size.width ;
    double ww =  MediaQuery.of(context).size.width/2 ;
    return   BlocProvider(
        create: (BuildContext context) => LoginCubit() ,
        child: BlocConsumer<LoginCubit, LoginStates>(
            listener: (context, state) => {},
            builder: (context, state) {
              var cubit = LoginCubit.get(context) ;
              print("amr");
              return Scaffold(
                  body: Container(
                   //color: Theme.of(context).cardColor,
                    child:Row(children: [
                      Container(
                          width: w/2,
                          height: h,
                          child: SingleChildScrollView(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: l?LogIn(cubit):SignUp(cubit),),
                          ))
                      ),
                      Container(
                          height: h,
                          width: w/2,
                          color: Theme.of(context).cardColor,
                          child: SingleChildScrollView(
                            child: Column (
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: hh,
                                    width : double.infinity ,
                                    child: Image(image: NetworkImage("https://images.unsplash.com/photo-1522836924445-4478bdeb860c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8bm90ZWJvb2t8ZW58MHx8MHx8fDA%3D"),fit: BoxFit.cover,)),
                                SizedBox(height: 50),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Never miss a brilliant idea again with Note.",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 30),
                                      Text("Simplify your life with Note - the ultimate note-taking app",style: TextStyle(fontSize:25,fontWeight: FontWeight.w400),),
                                      SizedBox(height: 30),
                                      Text("Unlock your creativity with Note",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 30,),
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10)),
                                        child: MaterialButton(onPressed: ()async {
                                         await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "amrabogabal77@gmail.com", password: "123456789");
                                         print("eeeeeeeeeeee");
                                         print(FirebaseAuth.instance.currentUser);
                                         print("**********************************");
                                         print(FirebaseAuth.instance.currentUser!.email) ;
                                         await FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value){
                                           print("Goooooooooooood");
                                         }).catchError((e){
                                           print(e.toString());
                                           print("Noooooooooooooooooooooooooooooooooooooooooooooooooooooo");
                                         });
                                         print("eeeeeeeeeeeeeeeeeeeee");
                                         //await FirebaseAuth.instance.signInWithEmailAndPassword(email: "amrabogabal77@gmail.com", password: "123456789");
                                          //print(FirebaseAuth.instance.currentUser);
                                          //print(FirebaseAuth.instance.currentUser!.sendEmailVerification());
                                          setState(() {
                                            l = !l ;
                                          });
                                        },child: Text(l?"Sign Up":"Log In",style: TextStyle(color: Colors.white,fontSize: 30),),),)
                                    ],),
                                )
                              ],),
                          )
                      ),
                    ],),));

            }
        )
    );
  }
  Widget LogIn(cubit){
    return  Form(
      key: formKeyL,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200,),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [Text("Log In",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)],)),
            SizedBox(height: 20,),
            Text("Email",style: TextStyle(fontSize: 30),),
            SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffe8edea) ,
              ),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: Email,
                decoration: InputDecoration(border: InputBorder.none),
              ),),
            SizedBox(height: 5,),
            Text("Password",style: TextStyle(fontSize: 30),),
            SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffe8edea) ,
              ),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The Password is Empty';
                  }
                  if (value.length<7) {
                    return 'The password is short';
                  }
                  return null;
                },
                controller: Password,
                decoration: InputDecoration(border: InputBorder.none),
              ),),
            SizedBox(height: 5,),
            TextButton(onPressed:(){}, child:  Text("Forget Your Password ? ",style: TextStyle(color:Colors.red,fontSize: 30),)),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(10)),
                child: MaterialButton(onPressed: () async{
                  await cubit.SignIn(Email.text.trim(),Password.text,context);
                },child: Text("Log In",style: TextStyle(color: Colors.white,fontSize: 40),),),),
            )
          ],),
    );
  }
  Widget SignUp(cubit){
    return Form(
      key: formKeyS,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100,),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [Text("Sign Up",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),)],)),
          SizedBox(height: 20,),
          Text("Email",style: TextStyle(fontSize: 30),),
          SizedBox(height: 5,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffe8edea) ,
            ),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'The Email is Empty';
                }
                return null;
              },
              controller: EmailS,
              decoration: InputDecoration(border: InputBorder.none),

                          ),),
          Text("Name",style: TextStyle(fontSize: 30),),
          SizedBox(height: 5,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffe8edea) ,
            ),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'The Name is Empty';
                }
                return null;
              },
              controller: Name,
              decoration: InputDecoration(border: InputBorder.none),

            ),),
          SizedBox(height: 5,),
          Text("Password",style: TextStyle(fontSize: 30),),
          SizedBox(height: 5,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffe8edea) ,
            ),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'The Password is Empty';
                }
                if (value.length<7) {
                  return 'The password is short';
                }
                return null;
              },
              controller: PasswordS,
              decoration: InputDecoration(border: InputBorder.none),
            ),),
          Text("Confirm Password",style: TextStyle(fontSize: 30),),
          SizedBox(height: 5,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffe8edea) ,
            ),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'The Password is Empty';
                }
                if (value.length<7) {
                  return 'The password is short';
                }
                if (value!=PasswordS.text) {
                  return 'The password does not match';
                }
                return null;
              },
              controller: PasswordSC,
              decoration: InputDecoration(border: InputBorder.none),
            ),),
          SizedBox(height: 5,),
          Text("ِAdd Your Image ",style: TextStyle(fontSize: 30),),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(onPressed:(){
                  cubit.getProfileImage();
                }, icon: Icon(Icons.camera_alt_outlined,size: 50,)),
                Spacer(),
                cubit.SelectImage?Container(
                  height : 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10)
                    ),
                    image: DecorationImage(
                      image:FileImage(cubit.profileImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ):Text("No Image Selected",style: TextStyle(fontSize: 40),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(10)),
              child: MaterialButton(onPressed: ()async{
                  if(formKeyS.currentState!.validate()){
                    bool result = await InternetConnectionChecker().hasConnection;
                    if(result == true) {
                      cubit.uploadProfileImage(EmailS.text.trim() , PasswordS.text.trim(),Name.text ,context);
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(
                          msg:"No Internet",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                  }
              }
              ,child:cubit.isloading==true?Center(child: CircularProgressIndicator()):Text("SignUp",style: TextStyle(color: Colors.white,fontSize: 30),),
              ),),
          ),

        ],),
    ) ;
  }
}
