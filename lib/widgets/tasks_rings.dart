import 'package:flutter/material.dart';
import 'package:todo_list/data/tasks_storage.dart';
import 'package:todo_list/models/task.dart';

List<Color> listpOfPlaceholderColors = [
  Colors.black54,
  Colors.black45,
  Colors.black26,
];

class TasksRings extends StatelessWidget {
  final CategoriesManager categories;

  const TasksRings({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(240, 290),
      painter: _RingsPainter(categories),
    );
  }
}

class _RingsPainter extends CustomPainter {
  final CategoriesManager categoriesManager;

  _RingsPainter(this.categoriesManager);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    double strokeWidth = 10;
    double gap = 5;

    int counter = 0;

    double calcStrokeWidth(double x) {
      return (-5 / 3) * x + (70 / 3);
    }

    double calcGap(double x) {
      return (-2 / 3) * x + (31 / 3);
    }

    void paintPlacleholderRing() {
      for (final color in listpOfPlaceholderColors) {
        final progress = ((counter + 1) * 0.3) - counter * 0.1;
        strokeWidth = 20;
        gap = 9;

        final radius = size.width / 2 - (counter * (strokeWidth + gap));

        final backgroundPaint = Paint()
          ..color = color.withOpacity(0.15)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

        final progressPaint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth;

        canvas.drawCircle(center, radius, backgroundPaint);

        final sweepAngle = 2 * 3.141592653589793 * progress;
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          -3.1415926535 / 2,
          sweepAngle,
          false,
          progressPaint,
        );

        counter++;
      }
    }

    void paintUsefulRing() {
      final categoryCount =
          categoriesManager.usefulCategories.length.toDouble();
      strokeWidth = calcStrokeWidth(categoryCount);

      gap = calcGap(categoryCount);
      for (final category in categoriesManager.usefulCategories) {
        final progress = categoriesManager.fillTheTaskRing(
            tasks: registeredTasks, category: category);

        final radius = size.width / 2 - (counter * (strokeWidth + gap));

        final backgroundPaint = Paint()
          ..color = category.color.withOpacity(0.1)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

        final progressPaint = Paint()
          ..color = category.color
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth;

        canvas.drawCircle(center, radius, backgroundPaint);

        final sweepAngle = 2 * 3.141592653589793 * progress;
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          -3.1415926535 / 2,
          sweepAngle,
          false,
          progressPaint,
        );

        counter++;
      }
    }

    if (categoriesManager.usefulCategories.isEmpty) {
      paintPlacleholderRing();
    } else {
      paintUsefulRing();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
