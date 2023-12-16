import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/Cubits/AppCubit/States.dart';
import 'package:note/Cubits/AppCubit/cubit.dart';
import 'package:note/Models/TaskModel.dart';
import 'package:note/Widget.dart';
import 'package:intl/intl.dart';


class  HomeP  extends StatelessWidget {
  List<Color> MyColorsW = [Color(0xffc4c712),Color(0xff6ec969),Color(0xffc96999),Color(0xffc99142),Color(0xff988df2)] ;
  List<Color> MyColorsB = [Color(0xff291f1e),Color(0xff1a1710),Color(0xff1a1919),Color(0xff454444),Color(0xff170000)] ;
  List<int> items = [1,2,3,5,6,67,9];
  var sec = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitOfMyApp, States>(
    listener: (context, state) => {},
    builder: (context, state) {
    var cubit = CubitOfMyApp.get(context) ;
    if(cubit.TasksData==false){
      cubit.GetTasks();
    }
    print(cubit.Sections);
    print(cubit.TasksData);
    return Scaffold(
      body: cubit.TasksData==false?Center(child: CircularProgressIndicator(color: Colors.red,)):Container(
          //color: Color(0xff171716),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage("${cubit.user!.image}"),
                    ),
                    SizedBox(width: 10,),
                    Expanded(child: Text("${cubit.user!.name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,),)),
                  ],),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Text("My Notes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,),),
                      Spacer(),
                      IconButton(onPressed:(){
                        cubit.Refresh() ;
                      }, icon: Icon(Icons.refresh_outlined))
                    ],
                  ),
                   SizedBox(height: 20,),
                    Container(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount:cubit.Sections.length==0?1:cubit.Sections.length+1,
                        itemBuilder:(context,index)=>StyleC(index,cubit,context),
                        separatorBuilder: (context,index)=>SizedBox(width: 10,) ,
                      ),),
                    SizedBox(height: 20,),
                    MaterialButton(
                      onPressed: () {
                        cubit.ChangePage(1);
                      },
                      child: Container(
                        child: Center(child: Icon(Icons.add,size: 40,),),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("${cubit.AllTasks.length}"),
                    Text("${cubit.TasksData}"),
                    cubit.AllTasks.length==0?Center(child: Text("No Tasks In This Section")):Container(
                      height:MediaQuery.of(context).size.height,
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context,index)=>ListStyle(context,cubit.dark==true?MyColorsB:MyColorsW,index,cubit,cubit.AllTasks[cubit.TaskS],),
                          separatorBuilder: (context,index)=>SizedBox(height: 10,),
                          itemCount:cubit.AllTasks[cubit.TaskS].length
                      ),
                    ),
                  ],),
                ],),
            ),
          ),
        ),
    );
         }
    );
  }
  Widget StyleC(index, CubitOfMyApp cubit,context){
    return MaterialButton(
      onPressed: () {
        if(index==0){
          print("وووووووووووووووووووووووووووووووووووووووووووووووووووووووووووووو");
          print("ooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
          cubit.pr();
          print("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
          Scaffold.of(context).showBottomSheet<void>(
                  (BuildContext context) {
                    return BottonSheet(context,cubit);
                    });
              }
        else {
          cubit.TaskS = index-1 ;
          print(cubit.TaskS);
        }
        cubit.ChangeItemSelected(index) ;
      },
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: SectionColor(index,cubit.ItemSelected),
            border: Border.all() ,
          ),
        child: Center(
            child: Text(index==0?"Add Section":"${cubit.Sections[index-1]}",style: TextStyle(color :index==0?Colors.red:Colors.black),))),
    );
  }
  Widget ListStyle(context, List<Color> myColors,index,cubit, List<TaskModel> allTask){
    return Dismissible(
     onDismissed: (f){
       print("OnDismissed");
     },
      confirmDismiss: (f) async {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete',style: TextStyle(fontSize: 30),),
              content: const Text(
                'Are You Want To Delete This Item ?.',
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Yes',style: TextStyle(color: Colors.red),),
                  onPressed: () {
                    items.removeAt(index) ;
                    cubit.Refresh() ;
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                  child: const Text('No',style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      background: Container(
        //color: Colors.white,
          child: Text(allTask[index].Subject)),
      key: ValueKey<int>(items[index]),
      child: Container(
          //height:230,
          decoration: ContinerStyle(myColors[index%5]),
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: (){
                cubit.M = cubit.AllTasks[index];
                cubit.ChangePage(2);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width-100,
                    child: Row(children: [
                      Expanded(child: Text("${cubit.AllTasks[cubit.TaskS][index].Title}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                      Text("${DateFormat('yyyy-MM-dd – kk:mm').format(cubit.AllTasks[cubit.TaskS][index].Date)}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                    ],),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width-100,
                      child: Text( allTask[index].Subject,
                        maxLines: 4,overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
                      )),
                ],),
            ),
          ),
      ),
    );
  }
  Widget BottonSheet(context,cubit){
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20) ,
          topRight: Radius.circular(20) ,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Add a New Section',style: TextStyle(fontSize: 25),),
            SizedBox(height: 10,),
            Container(
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: sec,
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child:  Text('Add',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.green),),
              onPressed: () async {
                cubit.AddSections(sec.text);
                Navigator.pop(context);
               await cubit.Refresh();
              },
            ),
          ],
        ),
      ),
    ) ;
  }
}
