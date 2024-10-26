import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoey/models/task_data.dart';

class SharedPreferencesLocal {
  static Future<void> initializeApp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get saved tasks list
    final List<String>? tasks = prefs.getStringList('tasks');
    final List<String>? tasksState = prefs.getStringList('tasksState');
    TaskData.loadTasks(tasks ?? [], tasksState ?? []);
  }

  static Future<void> saveTasks(
      List<String> tasks, List<String> tasksState) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', tasks);
    await prefs.setStringList('tasksState', tasksState);
  }
}
