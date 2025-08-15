import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';

enum TaskType { todo, completed }

class TodoItem extends StatelessWidget {
  TodoItem(
      {required this.task,
      required this.onLeftDirection,
      required this.onRightDirection,
      super.key})
      : taskIsCompleted = task.isCompleted;

  final Task task;
  final void Function(Task) onLeftDirection;
  final void Function(Task) onRightDirection;
  final bool taskIsCompleted;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.horizontal,
      key: ValueKey(task),
      background: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.5),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              taskIsCompleted ? Icons.delete_forever_rounded : Icons.delete,
              size: 35,
              color: Colors.white,
              applyTextScaling: true,
            ),
          ),
        ),
      ),
      secondaryBackground: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.5),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: taskIsCompleted ? Colors.grey : Colors.green,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              taskIsCompleted
                  ? Icons.settings_backup_restore_rounded
                  : Icons.done_all_rounded,
              size: 35,
              color: Colors.white,
              applyTextScaling: true,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onLeftDirection(task);
        } else {
          onRightDirection(task);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(6, 0, 0, 0),
          border: Border(
            bottom: BorderSide(color: Color.fromARGB(40, 0, 0, 0), width: 1.5),
            right: BorderSide(color: Color.fromARGB(40, 0, 0, 0), width: 0.75),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6.5),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: task.category.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(task.category.icon),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      task.textTask,
                    ),
                    Text(
                      style: TextStyle(
                        color: task.category.color,
                        fontSize: 13,
                      ),
                      task.category.name,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
