import 'package:flutter/material.dart';
import 'package:todo_list/data/categories_storage.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/widgets/todo.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({required this.submitTask, super.key});

  final Function(Task) submitTask;

  @override
  State<NewTodo> createState() {
    return _NewTodoState();
  }
}

class _NewTodoState extends State<NewTodo> {
  final _titleController = TextEditingController();
  Category? selectedCategory = registeredCategories.categoriesList.isNotEmpty
      ? registeredCategories.categoriesList[0]
      : null;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _submitTask() {
    if (_titleController.text.trim().length < 4) {
      ErrorManager.showError(ErrorTypes.taskInputError, context);
    } else if (selectedCategory == null) {
      ErrorManager.showError(ErrorTypes.categoryNotSelected, context);
    } else {
      //submit task
      widget.submitTask(
        Task(
            textTask: _titleController.text.trim(),
            category: selectedCategory!),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20 + keyboardSpace),
          child: Column(
            children: [
              TextField(
                maxLength: 80,
                controller: _titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'The task text',
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: Text(
                  'Select a category',
                ),
              ),

              //categories's list
              Column(
                children: registeredCategories.categoriesList.map((category) {
                  final isSelected = category == selectedCategory;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isSelected
                                ? Colors.black.withOpacity(0.7)
                                : Colors.black.withOpacity(0.2),
                            width: 2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(14),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 6.5),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? category.color
                                  : category.color.withOpacity(0.6),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              category.icon,
                              color: isSelected
                                  ? Colors.black.withOpacity(0.85)
                                  : Colors.black.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    style: TextStyle(
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.black.withOpacity(0.6),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                    category.name,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: _submitTask,
                      child: const Text('Save'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
