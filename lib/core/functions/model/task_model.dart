class TaskModel {
  String id;
  String title;
  String note;
  String date;
  String startTime;
  String endTime;
  int color;
  bool iscompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.iscompleted,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? note,
    String? date,
    String? startTime,
    String? endTime,
    int? color,
    bool? iscompleted,
  }) {
    return TaskModel(
      id: this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      iscompleted: iscompleted ?? this.iscompleted,
    );
  }
}
