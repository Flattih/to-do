import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/models/task.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task_data.dart';
import 'package:to_do/widgets/item_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "title",
          style: GoogleFonts.dongle(fontSize: 30),
        ).tr(),
        leading: IconButton(
            onPressed: () {
              Provider.of<ItemData>(context, listen: false).changeTheme();
            },
            icon: const Icon(Icons.nightlight_round_outlined)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    left: 15, bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextField(
                  style: GoogleFonts.dongle(
                      color: Colors.deepPurpleAccent.shade700, fontSize: 30),
                  onSubmitted: (value) {
                    if (2 <= value.length) {
                      Navigator.pop(context);

                      Provider.of<ItemData>(context, listen: false)
                          .addTask(task: Task.create(task: value));
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "keyboard".tr(),
                  ),
                  autofocus: true,
                ),
              );
            },
          );
        },
      ),
      body: ListView.builder(
        itemCount: Provider.of<ItemData>(context).taskBox.length,
        itemBuilder: (context, index) {
          Task? currentTask =
              Provider.of<ItemData>(context).taskBox.getAt(index);
          return ItemCard(task: currentTask);
        },
      ),
    );
  }
}
