import 'package:flutter/material.dart';
import 'package:todo_list/data/categories_storage.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/widgets/placeholders.dart';
import 'package:todo_list/widgets/tasks_rings.dart';
import 'package:todo_list/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  const TodoList(
      {super.key,
      required this.onComplete,
      required this.onRemove,
      required this.tasks});

  final List<Task> tasks;
  final void Function(Task) onRemove;
  final void Function(Task) onComplete;

  @override
  Widget build(BuildContext context) {
    final tasksInWork = tasks.where((task) => !task.isCompleted).toList();

    return Column(
      children: [
        TasksRings(categories: registeredCategories),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: tasksInWork.isNotEmpty
                ? ListView.builder(
                    itemCount: tasksInWork.length,
                    itemBuilder: (context, index) {
                      final task = tasksInWork[index];
                      return TodoItem(
                        task: task,
                        key: ValueKey(task),
                        onLeftDirection: onRemove,
                        onRightDirection: onComplete,
                      );
                    },
                  )
                : const Placeholders.tasks(),
          ),
        ),
      ],
    );
  }
}
