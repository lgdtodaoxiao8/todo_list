import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/data/categories_storage.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/widgets/categories_list.dart';
import 'package:todo_list/widgets/completed_todo_list.dart';
import 'package:todo_list/widgets/custom_tab_bar.dart';
import 'package:todo_list/widgets/new_category.dart';
import 'package:todo_list/widgets/new_todo.dart';
import 'package:todo_list/widgets/todo_list.dart';
import 'package:todo_list/data/tasks_storage.dart';

enum Screens { tasks, categories, completedTasks }

enum ErrorTypes {
  taskInputError,
  categoryNotSelected,
  categoryInputError,
  categoriesCoflict,
  noCategoriesExist,
  maxCategoryCount,
}

abstract class ErrorManager {
  static const Map<ErrorTypes, List<String>> errorText = {
    ErrorTypes.taskInputError: [
      'Invalid input',
      'The task text can\'t be less than 4 characters.',
    ],
    ErrorTypes.categoryNotSelected: [
      'Category is not selected',
      'Try to select a category or add some category if it\'s nothink to select.',
    ],
    ErrorTypes.categoryInputError: [
      'Invalid input',
      'The name of category can\'t be less than 4 characters',
    ],
    ErrorTypes.categoriesCoflict: [
      'Oops, somethink went wrong',
      'This is some categories conflict. \nTry to change the name, color or icon of category',
    ],
    ErrorTypes.maxCategoryCount: [
      'Max category count',
      'You have riched the max available category count. Try to delete existing category and create the new one or edit any existing category.',
    ],
    ErrorTypes.noCategoriesExist: [
      'No categories exist',
      'To create a task you should have at least one category to singn task in. Try to create category for the task by tapping at the button on top of the screen.'
    ],
  };

  static void showError(ErrorTypes error, BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text(errorText[error]![0]),
          content: Text(errorText[error]![1]),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(errorText[error]![0]),
          content: Text(errorText[error]![1]),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }
}

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() {
    return _TodoState();
  }
}

Screens curentSrceen = Screens.tasks;

class _TodoState extends State<Todo> {
  void switchScreen(Screens screen) {
    setState(() {
      curentSrceen = screen;
    });
  }

  void onTaskRemove(Task task) {
    setState(() {
      registeredTasks.remove(task);
    });
  }

  void markAsCompleted(Task task) {
    setState(() {
      task.markTaskAsCompleted();
    });
  }

  void markAsNotCompletedBack(Task task) {
    setState(() {
      task.markTaskAsNotCompletedBack();
    });
  }

  void saveTask(Task task) {
    setState(() {
      registeredTasks.add(task);
    });
  }

  void saveCategory(Category category) {
    setState(() {
      registeredCategories.addCategoryToStorage(category);
    });
  }

  void openAddCategoryScreen() {
    if (_canCreateNewCategory()) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        useSafeArea: true,
        builder: (ctx) => NewCategory(
          onSave: saveCategory,
        ),
      );
    } else {
      ErrorManager.showError(ErrorTypes.maxCategoryCount, context);
      //_throwMaxCategoryCountError();
    }
  }

  bool _canCreateNewCategory() {
    return registeredCategories.categoriesList.length < 8 &&
        registeredCategories.availableColors.isNotEmpty;
  }

  void openAddTaskScreen() {
    if (registeredCategories.categoriesList.isNotEmpty) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        useSafeArea: true,
        builder: (ctx) => NewTodo(submitTask: saveTask),
      );
    } else {
      ErrorManager.showError(ErrorTypes.noCategoriesExist, context);
    }
  }

  void removeCategoryWitnItsTasks(Category category) {
    setState(() {
      registeredTasks.removeWhere((task) => task.category == category);
      registeredCategories.removeCategoryFromStorage(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = TodoList(
        onComplete: markAsCompleted,
        onRemove: onTaskRemove,
        tasks: registeredTasks);

    if (curentSrceen == Screens.categories) {
      activeScreen = CategoriesList(
        onRemove: removeCategoryWitnItsTasks,
      );
    } else if (curentSrceen == Screens.completedTasks) {
      activeScreen = CompletedTodoList(
          onLeftDirection: onTaskRemove,
          onRightDirection: markAsNotCompletedBack,
          tasks: registeredTasks);
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: openAddCategoryScreen,
            //show modalButtonSheet category
            icon: const Icon(Icons.post_add_rounded),
          ),
          IconButton(
            onPressed: openAddTaskScreen,
            //show modalButtonSheet task
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
        ],
        title: const Text('Task Manager'),
        centerTitle: true,
        bottom: CustomTabBar(
          onTap: switchScreen,
        ),
      ),
      body: activeScreen,
    );
  }
}
