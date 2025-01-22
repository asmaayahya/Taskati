// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/functions/model/task_model.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/text_style.dart';

class task_item extends StatelessWidget {
  final TaskModel task;
  const task_item({
     
     required this.task,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     margin: EdgeInsets.only( bottom: 10,left: 5,right: 5),
    padding: EdgeInsets.all(10),
     decoration: BoxDecoration(
              
       color: task.color == 0 ? AppColor.primaryColor
       :task.color == 1 ? AppColor.orangecolor
       :AppColor.redcolor,
       borderRadius: BorderRadius.circular(5),
       
     ),
     child: Row(
       children: [
         Expanded(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                Text(task.title, style: getTitleTextStyle(fontSize: 16,color: AppColor.whitecolor,fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,),
                SizedBox(height: 3,),
                Row(children: [
                Icon(Icons.access_time, 
                 size: 15, color: AppColor.whitecolor),
                SizedBox(width: 3,),
                Text(task.startTime + " : " + task.endTime, style: TextStyle(fontSize: 15, color: AppColor.whitecolor, fontWeight: FontWeight.w400))
                ]),
               
                         ],
           ),
         ),
         Container(
           width: 1,
           color: AppColor.whitecolor,
           height: 50,
    
         ),
         RotatedBox(quarterTurns: 3,child: Text("TODO",style: getTitleTextStyle(
           fontSize: 16,color: AppColor.whitecolor, fontWeight: FontWeight.w400
         ),))
       ],
     ),
    );
  }
}
