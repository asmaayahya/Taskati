import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/core/components/custom_button.dart';
import 'package:flutter_application_1/core/functions/model/task_model.dart';
import 'package:flutter_application_1/core/functions/navigations.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/text_style.dart';
import 'package:flutter_application_1/features/home/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var formkey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var dateController = TextEditingController(
    text: DateFormat("dd/MM/yyyy").format(DateTime.now()),
  );
  var startTimeController = TextEditingController(
    text: DateFormat("hh:mm a").format(DateTime.now()),
  );
  var endTimeController = TextEditingController(
    text: DateFormat("hh:mm a").format(DateTime.now().add(Duration(minutes: 30))),
  );
  int selectedColor = 0;
  DateTime _parseTime(String timeString) {
  // Using DateFormat to parse the time string
  return DateFormat("hh:mm a").parse(timeString);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text('Add Task', style: getTitleTextStyle(color: AppColor.whitecolor,fontSize: 22, fontWeight: FontWeight.w600)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: AppColor.whitecolor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: getTitleTextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required';
                    } else if (value.length < 5) {
                      return 'Title should be at least 5 characters long';
                    }
                    return null;
                  },
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Enter task title...",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Note",
                  style: getTitleTextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: noteController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter your note",
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Note is required"; // Validation message
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Date",
                  style: getTitleTextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2026),
                    ).then((value) {
                      if (value != null) {
                        dateController.text = DateFormat("dd/MM/yyyy").format(value);
                      }
                    });
                  },
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Enter task date...",
                    suffixIcon: Icon(
                      Icons.calendar_month,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Start Time",
                            style: getTitleTextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(
                            fontSize: 15, 
                            
                            ),
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value != null) {
                                  startTimeController.text = value.format(context);
                                }
                              });
                            },
                            controller: startTimeController,
                            readOnly: true,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.access_time,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "End Time",
                            style: getTitleTextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(
                            fontSize: 15, 
                            
                            ),
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value != null) {
                                  endTimeController.text = value.format(context);
                                }
                              });
                            },
                            controller: endTimeController,
                            readOnly: true,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.access_time,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColor = index;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: index == 0
                                    ? AppColor.primaryColor
                                    : index == 1
                                        ? AppColor.orangecolor
                                        : AppColor.redcolor,
                                radius: 15,
                                child: selectedColor == index
                                    ? Icon(Icons.check, color: AppColor.whitecolor)
                                    : null,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        text: ("Create Task"),
                        width: 150,
                        onPressed: () {
                           if (formkey.currentState!.validate()) {
    // Time validation using DateFormat to parse the AM/PM time
    DateTime startTime = _parseTime(startTimeController.text);
    DateTime endTime = _parseTime(endTimeController.text);

    // Check if the end time is later than the start time
    if (startTime.isAfter(endTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("End time must be later than start time")),
      );
      return;
    }

                            TaskModel newtask = TaskModel(
                              id: DateTime.now().toString() + titleController.text,
                              title: titleController.text,
                              note: noteController.text,
                              date: dateController.text,
                              startTime: startTimeController.text,
                              endTime: endTimeController.text,
                              color: selectedColor,
                              iscompleted: false,
                            );
                            var taskBox = Hive.box("task");
                            taskBox.put(newtask.id, newtask);
                            pushWithReplacment(context, HomeScreen());
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
