import 'package:todo_list/widgets/todo.dart';

import 'package:flutter/material.dart';

final Map<Screens, String> buttonsText = {
  Screens.tasks: 'Tasks',
  Screens.categories: 'Categories',
  Screens.completedTasks: 'Completed',
};

class CustomTabBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomTabBar({required this.onTap, super.key});

  final Function(Screens) onTap;

  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  State<StatefulWidget> createState() {
    return _CustomTabBarState();
  }
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: Screens.values
            .map(
              (screen) => TabBarButton(
                onTap: widget.onTap,
                screen: screen,
                isSelected: screen == curentSrceen,
              ),
            )
            .toList(),
      ),
    );
  }
}

class TabBarButton extends StatelessWidget {
  const TabBarButton(
      {required this.onTap,
      required this.screen,
      required this.isSelected,
      super.key});

  final Screens screen;
  final Function(Screens) onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(screen);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromARGB(14, 0, 0, 0),
          border: Border(
            bottom: BorderSide(
              color:
                  isSelected ? Colors.black : const Color.fromARGB(0, 0, 0, 0),
              width: 1.5,
            ),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
          child: Text(
            buttonsText[screen]!,
            style: isSelected
                ? const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                  )
                : const TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                  ),
          ),
        ),
      ),
    );
  }
}
