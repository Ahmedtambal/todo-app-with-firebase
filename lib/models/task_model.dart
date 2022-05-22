class TaskModel {
  late String task;
  late String taskID;
  late String date;

  TaskModel({
    required this.task,
    required this.date,
    required this.taskID,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> _data = {
      "task": this.task,
      "date": this.date,
      "taskID": this.taskID,
    };
    return _data;
  }

  TaskModel.formJson(Map<String, dynamic> jsonData) {
    task = jsonData["task"];
    date = jsonData["date"];
    taskID = jsonData["taskID"];
  }
}
