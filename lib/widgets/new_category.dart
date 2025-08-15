import 'package:flutter/material.dart';
import 'package:todo_list/data/categories_storage.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/widgets/todo.dart';

class NewCategory extends StatefulWidget {
  const NewCategory({super.key, required this.onSave});

  final Function(Category) onSave;

  @override
  State<NewCategory> createState() {
    return _NewCategoryState();
  }
}

class _NewCategoryState extends State<NewCategory> {
  final _titleController = TextEditingController();
  Color? selectedColor = registeredCategories.availableColors.firstOrNull;
  IconData? selectedIcon = registeredCategories.availableIcons.firstOrNull;

  static const int iconsCountOneRow = 6;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _submitCategory() {
    final newCategory = Category(
        name: _titleController.text.trim().toLowerCase(),
        color: selectedColor!,
        icon: selectedIcon!);
    if (_titleController.text.trim().length < 3) {
      ErrorManager.showError(ErrorTypes.categoryInputError, context);
    } else {
      if (!registeredCategories.checkCategory(newCategory)) {
        ErrorManager.showError(ErrorTypes.categoriesCoflict, context);
      } else {
        widget.onSave(newCategory);
        Navigator.pop(context);
      }
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
          child: LayoutBuilder(
            builder: (ctx, constrains) {
              var colorElementSize = constrains.maxWidth /
                  registeredCategories.availableColors.length;
              colorElementSize = colorElementSize > 60 ? 60 : colorElementSize;

              final colorSize = colorElementSize * 0.9;
              final colorMargin = colorElementSize * 0.05;

              var iconElementSize = constrains.maxWidth / iconsCountOneRow;
              iconElementSize = iconElementSize > 60 ? 60 : iconElementSize;
              final iconSize = iconElementSize * 0.8;
              final iconMargin = iconElementSize * 0.1;

              return Column(
                children: [
                  TextField(
                    maxLength: 50,
                    controller: _titleController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'The category name',
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10),
                    child: Text(
                      'Select a color for category',
                    ),
                  ),

                  //color's row
                  Row(
                    children: registeredCategories.availableColors.map((color) {
                      final isSelected = color == selectedColor;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: colorMargin),
                          width: colorSize,
                          height: colorSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                            border: isSelected
                                ? Border.all(color: Colors.black, width: 2)
                                : null,
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.done_rounded,
                                  color: Colors.black,
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10),
                    child: Text(
                      'Select an icon for category',
                    ),
                  ),

                  //icon's wrap
                  Wrap(
                    children: registeredCategories.availableIcons.map((icon) {
                      final isSelected = icon == selectedIcon;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIcon = icon;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(iconMargin),
                          width: iconSize,
                          height: iconSize,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade400,
                              border: isSelected
                                  ? Border.all(color: Colors.black, width: 2)
                                  : null),
                          child: Icon(
                            icon,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10),
                    child: Text('Preview your category'),
                  ),

                  //category's preview
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedColor,
                        border: Border.all(color: Colors.black, width: 2)),
                    width: 60,
                    height: 60,
                    child: Icon(selectedIcon),
                  ),
                  Text(
                    _titleController.text,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
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
                          onPressed: _submitCategory,
                          child: const Text('Save'),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
