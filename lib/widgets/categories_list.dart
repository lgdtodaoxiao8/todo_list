import 'package:flutter/material.dart';
import 'package:todo_list/data/categories_storage.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/widgets/category_item.dart';
import 'package:todo_list/widgets/placeholders.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key, required this.onRemove});

  final Function(Category) onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: registeredCategories.categoriesList.isNotEmpty
          ? ListView.builder(
              itemCount: registeredCategories.categoriesList.length,
              itemBuilder: (ctx, index) {
                final category = registeredCategories.categoriesList[index];
                return CategoryItem(
                  category,
                  onRemove: onRemove,
                  key: ValueKey(category),
                );
              },
            )
          : const Placeholders.categories(),
    );
  }
}
