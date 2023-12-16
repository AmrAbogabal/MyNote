import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TaskModel {
   String Id="";
   String Title="";

   String Subject="";

   DateTime Date = DateTime(0) ;

  TaskModel({required Title, required Subject, required Date, required Id,});

   TaskModel.fromJson(Map<String, dynamic> json)
   {
     Title = json['Title'];
     Id = json['Id'];
     Subject = json['Subject'];
     //Date = json['Date'];
     Date = (json["Date"] as Timestamp).toDate();
   }

  Map<String, dynamic> toJson() {
    return {
      'Title': Title,
      'Id': Id,
      'Subject': Subject,
      'Date': Date,
      // Include other fields as needed.
    };
  }
}
