import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/models/task_data.dart';

class ItemCard extends StatefulWidget {
  final Task? task;

  const ItemCard({Key? key, required this.task}) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) {
        Provider.of<ItemData>(context, listen: false)
            .deleteTask(task: widget.task);
      },
      key: Key(widget.task!.id),
      child: Card(
        color: widget.task!.isCompleted ? Colors.grey.shade500 : Colors.white,
        elevation: widget.task!.isCompleted ? 1 : 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          onTap: () {
            setState(() {
              widget.task!.isCompleted = !widget.task!.isCompleted;
            });
          },
          title: Text(
            widget.task!.task,
            style: TextStyle(
                color: Colors.black87,
                decoration: widget.task!.isCompleted
                    ? TextDecoration.lineThrough
                    : null),
          ),
        ),
      ),
    );
  }
}
