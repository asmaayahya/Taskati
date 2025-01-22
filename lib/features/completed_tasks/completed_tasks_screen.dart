import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/components/task_item.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/text_style.dart';
import 'package:hive/hive.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var taskBox = Hive.box("task");
    var completedTasks = taskBox.values.where((task) => task.iscompleted == true).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColor.whitecolor,
            size: 20,
          ),
        ),
        backgroundColor: AppColor.primaryColor,
        title: Text(
          'Completed Tasks',
          style: getTitleTextStyle(
            color: AppColor.whitecolor,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: completedTasks.isNotEmpty
          ? ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                var task = completedTasks[index];
                return Column(
                  children: [
                    SizedBox(height: 40,),
                    Padding(
                      
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: task_item(task: completedTasks[index]),
                    ),
                  ],
                );
              },
            )
          : Center(
              child: Text(
                "No completed tasks",
                style: getTitleTextStyle(
                  color: AppColor.secondaryColor,
                  fontSize: 18,
                ),
              ),
            ),
    );
  }
}
