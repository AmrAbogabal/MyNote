import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/Cubits/AppCubit/States.dart';
import 'package:note/Cubits/AppCubit/cubit.dart';

import 'package:note/Widget.dart';

import 'Login.dart';

class  Test  extends StatelessWidget {
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"),value: "USA"),
      DropdownMenuItem(child: Text("ar"),value: "ar"),
    ];
    return menuItems;
  }
  String selectedValue = "ar" ;
  var c = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return BlocConsumer<CubitOfMyApp, States>(
        listener: (context, state) => {},
    builder: (context, state) {
    var cubit = CubitOfMyApp.get(context) ;
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text("Adjust your setting",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
                  height:MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).scaffoldBackgroundColor
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      SizedBox(height: 50,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Dark Mode"),
                          ),
                          Spacer(),
                          Switch(
                            activeColor: Colors.red,
                              value: cubit.dark,
                              onChanged: (v){
                              cubit.ChangeMode(v);
                              })
                        ],),),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Name",),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: c,
                          decoration: InputDecoration(
                            hintText: cubit.user!.name,
                            enabled:true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              // Set border for focused state
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 3, color: Colors.red),
                                borderRadius: BorderRadius.circular(15),
                              )),
                            ),
                          ),
                      SizedBox(height: 10,),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                          ),
                            child: MaterialButton(onPressed:(){
                              if(c.text.length>0){
                                cubit.ChangeUserName(c.text);
                              }
                            },child: Text("Change",style: TextStyle(fontSize: 20,color: Colors.red),),)),
                      ),
                      SizedBox(height: 10,),
                      MaterialButton(
                        onPressed: () {
                          cubit.getProfileImage();
                          },
                        child: Center(
                          child: MaterialButton(onPressed:(){},child: CircleAvatar(
                            backgroundImage: NetworkImage("${cubit.M.image}"),
                            radius: 50,
                          ),),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                       child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: MaterialButton(onPressed:(){},child: Text("Change",style: TextStyle(fontSize: 20,color: Colors.red),),)),
                     ),
                      SizedBox(height: 10,),
                      Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: MaterialButton(onPressed:(){
                                Navigator.pushAndRemoveUntil<void>(
                                  context,
                                  MaterialPageRoute<void>(builder: (BuildContext context) =>  LogScreen()),
                                  ModalRoute.withName('/'),
                                );
                                cubit.LogOut();
                              },child: Text("Log Out",style: TextStyle(fontSize: 20,color: Colors.red),),)),
                        ),
                    ],),
                  ),
                ),
      ),
            );

            });
  }
}
