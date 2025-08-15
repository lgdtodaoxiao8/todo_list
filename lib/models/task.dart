import 'package:flutter/material.dart';
import 'package:todo_list/data/tasks_storage.dart';

class Category {
  Category({required this.name, required this.color, required this.icon});
  String name;
  Color color;
  IconData icon;
}

class Task {
  Task({
    required this.textTask,
    required this.category,
  }) : isCompleted = false;

  Task.complete({
    required this.textTask,
    required this.category,
    required this.isCompleted,
  });

  Category category;
  String textTask;
  bool isCompleted;

  void markTaskAsCompleted() {
    isCompleted = true;
  }

  void markTaskAsNotCompletedBack() {
    isCompleted = false;
  }
}

class CategoriesManager {
  CategoriesManager({required this.categoriesList});

  final List<Color> availableColors = [
    const Color.fromARGB(255, 255, 80, 80), //красный
    const Color.fromARGB(255, 255, 149, 84), //оранжевый
    const Color.fromARGB(255, 254, 230, 72), //желтый
    const Color.fromARGB(255, 152, 233, 90), //зеленый
    const Color.fromARGB(255, 77, 221, 240), //бирюзовый
    const Color.fromARGB(255, 105, 153, 255), //синий
    const Color.fromARGB(255, 205, 86, 226), //фиалетовый
    const Color.fromARGB(255, 253, 91, 253), //розовый
  ];

  final List<IconData> availableIcons = [
    Icons.work_rounded, // Работа
    Icons.school_rounded, // Учёба
    Icons.fitness_center_rounded, // Спорт
    Icons.shopping_cart_rounded, // Покупки
    Icons.pets_rounded, // Домашние животные
    Icons.attach_money_rounded, //Деньги
    Icons.fastfood_rounded, // Еда
    Icons.local_cafe_rounded, // Кофе/Кафе
    Icons.medical_services_rounded, // Здоровье
    Icons.directions_run_rounded, // Пробежка
    Icons.book_rounded, // Чтение
    Icons.movie_rounded, // Фильмы
    Icons.music_note_rounded, // Музыка
    Icons.brush_rounded, // Творчество
    Icons.camera_alt_rounded, // Фото
    Icons.flight_rounded, // Путешествия
    Icons.home_rounded, // Дом
    Icons.nightlight_round, // Сон/Релакс
    Icons.computer_rounded, // Компьютер
    Icons.language_rounded, // Языки
    Icons.star_rounded, // Важное
    Icons.lightbulb_rounded, // Идеи
    Icons.savings_rounded, // Финансы
    Icons.cleaning_services_rounded, // Уборка
    Icons.cake_rounded, // Праздники
    Icons.calendar_today_rounded, // Календарь
    Icons.timer_rounded, // Таймер
    Icons.wifi_rounded, // Интернет
    Icons.security_rounded, // Безопасность
    Icons.volunteer_activism_rounded, // Благотворительность
  ];

  List<Category> categoriesList;

  bool checkCategory(Category newCategory) {

    for (final existingCategory in categoriesList) {
      if (existingCategory.name == newCategory.name) {
        return false;
      }
    }
    return true;
  }

  void addCategoryToStorage(Category category) {
    availableColors.remove(category.color);
    availableIcons.remove(category.icon);
    categoriesList.add(category);
  }

  void removeCategoryFromStorage(Category category) {
    availableColors.add(category.color);
    availableIcons.add(category.icon);

    categoriesList.remove(category);
  }

  bool isUsefulCategory(Category category) {
    for (var task in registeredTasks) {
      if (task.category == category) {
        return true;
      }
    }
    return false;
  }

  List<Category> get usefulCategories {
    final List<Category> usefulCategories =
        categoriesList.where((category) => isUsefulCategory(category)).toList();
    return usefulCategories;
  }

  double fillTheTaskRing({
    required List<Task> tasks,
    required Category category,
  }) {
    var totalTasksCount = 0;
    var completedTasksCount = 0;
    for (final task in tasks) {
      if (task.category == category) {
        totalTasksCount++;
        if (task.isCompleted == true) {
          completedTasksCount++;
        }
      }
    }
    return completedTasksCount / totalTasksCount;
  }

}
