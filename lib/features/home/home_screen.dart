import 'dart:io';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/components/custom_button.dart';
import 'package:flutter_application_1/core/components/custom_row.dart';
import 'package:flutter_application_1/core/components/task_item.dart';
import 'package:flutter_application_1/core/functions/model/task_model.dart';
import 'package:flutter_application_1/core/functions/navigations.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/text_style.dart';
import 'package:flutter_application_1/features/add_task/add_task.dart';
import 'package:flutter_application_1/features/completed_tasks/completed_tasks_screen.dart';
import 'package:flutter_application_1/features/profile/profile_screen.dart';
import 'package:flutter_application_1/features/upload/upload_screen.dart';
import 'package:flutter_application_1/main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now(); // Track selected date

  @override
  Widget build(BuildContext context) {
    var userBox = Hive.box("user");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text(
          "Taskati",
          style: getTitleTextStyle(color: AppColor.whitecolor, fontSize: 22, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              pushTO(context, ProfileScreen());
            },
            icon: Icon(Icons.person, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              pushTO(context, CompletedTasksScreen());
            },
            icon: Icon(Icons.done_all, color: Colors.white),
          ),
          SizedBox(width: 20,)
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              custom_row(
                userBox: userBox,
                firstText: 'Hello ,'+userBox.get("name"),
                secondText: 'Have a nice day!',
                myWidget: CircleAvatar(
                  backgroundImage: userBox.get("image").startsWith("http")
                      ? NetworkImage(userBox.get("image")) 
                      : FileImage(File(userBox.get("image"))) as ImageProvider, 
                  radius: 45,
                ),
              ),
              SizedBox(height: 20,),
              custom_row(
                userBox: userBox,
                firstText: DateFormat("dd MMM, yyyy").format(DateTime.now()),
                secondText: 'Today',
                myWidget: CustomButton(
                  width:180,
                  height: 50,
                  text: "+ Add Task", 
                  onPressed: () {
                    pushTO(context, AddTaskScreen());
                  },
                 
                  backgroundColor: AppColor.primaryColor,
                )
              ),
              SizedBox(height: 20,),
              DatePicker(
                width: 80,
                height: 130,
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColor.primaryColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  setState(() {
                    selectedDate = date; 
                  });
                }
              ),
              SizedBox(height: 10,),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: Hive.box("task").listenable(),
                  builder: (BuildContext context, Box taskBox, Widget? child) {
                    
                    var tasks = taskBox.values
                        .where((task) {
                          
                          DateTime taskDate = DateFormat('dd/MM/yyyy').parse(task.date); 
                          
                          return task.iscompleted == false && 
                                 DateFormat('yyyy-MM-dd').format(taskDate) == DateFormat('yyyy-MM-dd').format(selectedDate);
                        })
                        .toList();

                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                             
                              taskBox.deleteAt(taskBox.values.toList().indexOf(tasks[index]));
                            } else {
                              
                              TaskModel existingTask = taskBox.get(tasks[index].id);
                              TaskModel updatedTask = existingTask.copyWith(iscompleted: true);
                              taskBox.put(existingTask.id, updatedTask);
                            }
                          },
                          key: UniqueKey(),
                          background: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: AppColor.rasbarrycolor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: AppColor.whitecolor,
                                    size: 18,
                                  ),
                                  SizedBox(width: 8), 
                                  Text(
                                    "Delete",
                                    style: getTitleTextStyle(
                                      fontSize: 18,
                                      color: AppColor.whitecolor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          secondaryBackground: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: AppColor.pistachiocolor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.done_outline_rounded,
                                    color: AppColor.whitecolor,
                                    size: 18,
                                  ),
                                  SizedBox(width: 8), 
                                  Text(
                                    "Done",
                                    style: getTitleTextStyle(
                                      fontSize: 18,
                                      color: AppColor.whitecolor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          child: task_item(task: tasks[index]),
                        );
                      },
                    );
                  }
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
