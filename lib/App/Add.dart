import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/Cubits/AppCubit/States.dart';
import 'package:note/Cubits/AppCubit/cubit.dart';
import 'package:note/Models/TaskModel.dart';


class  Add  extends StatelessWidget {
var T = TextEditingController();
var S = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitOfMyApp,States>(
        listener: (context,state)=>{} ,
    builder: (context,state) {
      var cubit = CubitOfMyApp.get(context);
      return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){
              cubit.ChangePage(0);
            }, icon: Icon(Icons.arrow_back,color: Theme.of(context).secondaryHeaderColor,)),
          ),
          centerTitle: true,
          title: Text("Add Item",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Theme.of(context).secondaryHeaderColor,),),
        ),
        body:Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text("Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w200),),
                SizedBox(height: 5,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                   // color: Color(0xffe8edea) ,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: T,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        //hintText: "   Write The Title",
                        hintStyle: TextStyle()
                      ),
                    ),
                  ),),
                SizedBox(height: 20,),
                Text("Write Here",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w200),),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width-50,
                  height: MediaQuery.of(context).size.height>500?MediaQuery.of(context).size.height-400:200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                    //color: Color(0xffe8edea) ,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: S,
                      style: TextStyle(fontSize: 20),
                      maxLines: 12,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          //hintText: "   Write the Details",
                          hintStyle: TextStyle()
                      ),
                    ),
                  ),),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(10)),
                    child: MaterialButton(onPressed: (){
                      cubit.AddTaskInSections(cubit.Sections[cubit.TaskS],T.text,S.text,DateTime.now());
                      cubit.ChangePage(0);
                    },child: Text("Add",style: TextStyle(color: Colors.white),),),),
                )
              ],
            ),
          ),
        ),
      ) ;
    }
    );
  }
}
