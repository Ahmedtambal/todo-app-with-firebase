import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:to_do_app_with_firebase/models/task_model.dart';

class HomeController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<TaskModel> tasks = [];
  bool state = false;

  onInit() {
    super.onInit();
    getTasks();
  }

  Future<void> createTask({
    required String textTask,
  }) async {
    TaskModel _task = TaskModel(
      task: textTask,
      date: DateTime.now().toString(),
      taskID: "",
    );
    _db
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("tasks")
        .add(_task.toMap())
        .then((value) {
      value.update({
        "taskID": value.id,
      });
      _task.taskID = value.id;
      tasks.insert(0, _task);
      update();
    });
  }

  Future<void> getTasks() async {
    tasks = [];
    state = true;
    update();
    await _db
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("tasks")
        .orderBy("date", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        tasks.add(TaskModel.formJson(element.data()));
      });
    });
    state = false;
    update();
  }

  Future<void> deleteTask({required TaskModel task}) async {
    tasks.remove(task);
    update();
    _db
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("tasks")
        .doc(task.taskID)
        .delete();
  }
}
