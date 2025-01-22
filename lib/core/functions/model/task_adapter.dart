import 'dart:convert';

import 'package:flutter_application_1/core/functions/model/task_model.dart';
import 'package:hive/hive.dart';

class TaskAdapter extends TypeAdapter<TaskModel>{
  @override
  TaskModel read(BinaryReader reader) {
    
  return TaskModel(
    id: reader.readString(),
    title: reader.readString(),
    date: reader.readString(),
    note:  reader.readString(),
    startTime: reader.readString(),
    endTime: reader.readString(),
    color:  reader.readInt(),
    iscompleted:  reader.readBool(),
     
   );
  
  }

  @override
  //  typeId 0 - 223
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, TaskModel obj) {

    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.date);
    writer.writeString(obj.note);
    writer.writeString(obj.startTime);
    writer.writeString(obj.endTime);
    writer.writeInt(obj.color);
    writer.writeBool(obj.iscompleted);
  }

  
}