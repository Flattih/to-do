import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/models/task.dart';

class ItemData extends ChangeNotifier {
  var taskBox = Hive.box<Task>("Data");
  var themeBox = Hive.box("ThemeMode");
  late bool mode;

  getTheme() {
    mode = themeBox.get("Theme", defaultValue: false);
    return mode;
  }

  Future<void> addTask({required Task task}) async {
    await taskBox.add(task);
    notifyListeners();
  }

  changeTheme() {
    themeBox.put("Theme", !mode);
    notifyListeners();
  }

  deleteTask({required Task? task}) async {
    await task!.delete();
    notifyListeners();
  }
}
