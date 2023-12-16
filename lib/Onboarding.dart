import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/Login.dart';
import 'Models/OnbordingModel.dart';

class  Onboarding extends StatefulWidget {

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<OnboardingModel> OnboardingItems= [
    OnboardingModel(image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKRC7_Qy5d_d9eUWdgAxv4RXRsxkMgEibyvw&usqp=CAU', Text: 'Taking notes is an important part of the life of every student. There are two main reasons why note-taking is important'),
    OnboardingModel(image: 'https://media.istockphoto.com/id/1415229613/photo/young-woman-using-smartphone-at-university.webp?b=1&s=170667a&w=0&k=20&c=gnfMq3kuh54FbnX4J9OynqXK9e8sr1ztdnQHg3pjia8=', Text: 'Start jotting down your thoughts and ideas with Note'),
    OnboardingModel(image: 'https://images.unsplash.com/photo-1652422485236-886645c581a3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8bm90ZXMlMjBhcHB8ZW58MHx8MHx8fDA%3D', Text: ' Get organized with Note - your go-to note-taking tool'),
  ] ;

  PageController? _controller = PageController(initialPage:0);

  int currentIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    double h =  MediaQuery.of(context).size.height ;
    double w =  MediaQuery.of(context).size.width ;
    return  Scaffold(
      body: MediaQuery.of(context).size.height<80?Text("The screen length is very small"):SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height-100,
              width: w ,
              child: PageView.builder(itemBuilder:(context,index)=>SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: h/2,
                      decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("${OnboardingItems[index].image}",),fit: BoxFit.fill)),
                    ),
                    SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: w/2,
                        child: Text("${OnboardingItems[index].Text}",maxLines: 6 ,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 35),),
                      ),
                    ),
                  ],),
              ),
                itemCount: 3,
               controller: _controller,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              )
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  OnboardingItems.length,
                      (index) => buildDot(index, context),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),
                      color: Colors.red

                  ),child: MaterialButton(onPressed:(){
                  if (currentIndex >0) {
                    setState(() {
                      _controller?.previousPage(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.easeInBack,
                      ) ;
                    });
                  }
                  if (currentIndex ==OnboardingItems.length-1) {
                    setState(() {
                      _controller?.jumpToPage(currentIndex-1) ;
                    });
                  }
                },
                ),
                ),
                SizedBox(width: 5,),
                Container(
                  width: w<600?w/2:w/6,
                  height: 50,
               decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),
                    color: Colors.greenAccent

                  ),child: MaterialButton(onPressed:(){
                  if (currentIndex == OnboardingItems.length - 1) {
                    Navigator.pushReplacement(
                        (context), MaterialPageRoute(
                        builder: (_) =>  LogScreen(),
                      ),
                    );
                  }
                  _controller?.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn,
                  );
                },child: Text(currentIndex == OnboardingItems.length - 1 ? "Continue" : "Next",style: TextStyle(fontSize: 30),),),),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: currentIndex==index?40:10,
      width:  10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:currentIndex==index?Colors.red:Colors.grey,
      ),
    );
  }
}
