import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  bool isCompleted;
  @HiveField(2)
  String task;

  Task({required this.id, required this.isCompleted, required this.task});

  factory Task.create({required String task}) {
    return Task(id: const Uuid().v1(), isCompleted: false, task: task);
  }


}
