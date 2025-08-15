import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(this.category, {super.key, required this.onRemove});

  final Function(Category) onRemove;
  final Category category;

  @override
  Widget build(context) {
    return Dismissible(
      background: Container(
        decoration: const BoxDecoration(
          color: Colors.red,
          border: Border(
            bottom: BorderSide(color: Color.fromARGB(40, 0, 0, 0), width: 2),
            right: BorderSide(color: Color.fromARGB(40, 0, 0, 0), width: 0.75),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        margin: const EdgeInsets.symmetric(vertical: 7),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Icon(
                Icons.delete,
                size: 30,
                color: Colors.white,
                applyTextScaling: true,
              ),
              Text(
                style: TextStyle(
                  color: Colors.white,
                  height: 1,
                ),
                'Delete category \nwith tasks',
              ),
              Spacer(),
              Text(
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.white,
                  height: 1,
                ),
                'Delete category \nwith tasks',
              ),
              Icon(
                Icons.delete,
                size: 35,
                color: Colors.white,
                applyTextScaling: true,
              ),
            ],
          ),
        ),
        
      ),
      key: ValueKey(category),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(6, 0, 0, 0),
          border: Border(
            bottom: BorderSide(color: Color.fromARGB(40, 0, 0, 0), width: 2),
            right: BorderSide(color: Color.fromARGB(40, 0, 0, 0), width: 0.75),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: category.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(category.icon, color: Colors.black),
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
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      category.name,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      onDismissed: (direction){
        onRemove(category);
      },
    );
  }
}
