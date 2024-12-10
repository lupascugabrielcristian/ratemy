import 'package:flutter/material.dart';

class CurrentGrade extends StatelessWidget {
  final int grade;

  const CurrentGrade({super.key, required this.grade});

  @override
  Widget build(BuildContext context) {
    if (grade > 0) {
      return Container(
        color: Colors.lightGreen,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(grade.toString(), style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

}
