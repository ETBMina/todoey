import 'package:flutter/foundation.dart';
import 'package:todoey/models/shared_preferences.dart';
import 'package:todoey/models/task.dart';
import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';

class TaskData extends ChangeNotifier {
  static List<Task> _tasks = [];

  static void loadTasks(List<String> tasks, List<String> tasksState) {
    for (int i = 0; i < tasks.length; i++) {
      _tasks.add(
          Task(name: tasks[i], isDone: tasksState[i] == '0' ? false : true));
    }
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    saveTasks();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    saveTasks();
    notifyListeners();
  }

  List<String> getTasksState() {
    List<String> tasksState =
        _tasks.map((task) => task.isDone ? '1' : '0').toList();
    return tasksState;
  }

  void saveTasks() {
    List<String> taskNames = _tasks.map((task) => task.name).toList();
    SharedPreferencesLocal.saveTasks(taskNames, getTasksState());
  }
}
