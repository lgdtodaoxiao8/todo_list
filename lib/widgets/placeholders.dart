import 'package:flutter/material.dart';

enum PlaceholderTypes { tasks, categories, completed }

Map<PlaceholderTypes, List<String>> placeholderList = {
  PlaceholderTypes.tasks: [
    'Task.',
    'Try to add one by tapping the button on the top of screen.',
    'lib/assets/images/new_task_unicolor.png',
  ],
  PlaceholderTypes.categories: [
    'Category.',
    'Try to add one by tapping the button on the top of screen.',
    'lib/assets/images/new_category_unicolor.png',
  ],
  PlaceholderTypes.completed: [
    'Completed task.',
    'Try to mark any task as completed by swiping any task from right to left on Tasks screen.',
    'lib/assets/images/complete_task_unicolor.png',
  ],
};

class Placeholders extends StatelessWidget {
  const Placeholders.tasks({super.key})
      : placeholderTypes = PlaceholderTypes.tasks;
  const Placeholders.categories({super.key})
      : placeholderTypes = PlaceholderTypes.categories;
  const Placeholders.completed({super.key})
      : placeholderTypes = PlaceholderTypes.completed;
  final PlaceholderTypes placeholderTypes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            'There is no one ${placeholderList[placeholderTypes]![0]}',
          ),
          const SizedBox(height: 5),
          Text(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
            placeholderList[placeholderTypes]![1],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(
              left: placeholderTypes == PlaceholderTypes.completed ? 0 : 40,
            ),
            child: Image.asset(
              cacheHeight: 100,
              color: Colors.black45,
              placeholderList[placeholderTypes]![2],
            ),
          ),
        ],
      ),
    );
  }
}
