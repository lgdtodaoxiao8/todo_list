import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/widgets/placeholders.dart';
import 'package:todo_list/widgets/todo_item.dart';

class CompletedTodoList extends StatelessWidget {
  const CompletedTodoList(
      {super.key,
      required this.onRightDirection,
      required this.onLeftDirection,
      required this.tasks});

  final List<Task> tasks;
  final void Function(Task) onLeftDirection;
  final void Function(Task) onRightDirection;

  @override
  Widget build(BuildContext context) {
    final tasksOutOfWork = tasks.where((task) => task.isCompleted).toList();
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: tasksOutOfWork.isNotEmpty
            ? ListView.builder(
                itemCount: tasksOutOfWork.length,
                itemBuilder: (context, index) {
                  final task = tasksOutOfWork[index];

                  return TodoItem(
                    task: task,
                    key: ValueKey(task),
                    onLeftDirection: onLeftDirection,
                    onRightDirection: onRightDirection,
                  );
                },
              )
            : const Placeholders.completed(),
      ),
    );
  }
}
