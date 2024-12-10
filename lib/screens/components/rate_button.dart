import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RateButton extends StatefulWidget {
  const RateButton({super.key, required this.saveGrade});

  final Function(int) saveGrade;

  @override
  State<RateButton> createState() => _RateButtonState();
}

class _RateButtonState extends State<RateButton> {
  final GlobalKey _rateContainerKey = GlobalKey();
  bool showGrades = false;
  int selectedGrade = 0;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        setState(() {
          showGrades = false;
        });
      },
      onVerticalDragStart: (details) {
        setState(() {
          showGrades = true;
        });
      },
      onVerticalDragEnd: (details) {
        setState(() {
          widget.saveGrade(selectedGrade);
          showGrades = false;
          selectedGrade = 0;
        });
      },
      onVerticalDragUpdate: (details) {
        final renderBox = _rateContainerKey.currentContext!.findRenderObject() as RenderBox;

        log('Cursor Y=${details.localPosition.dy} in box height ${renderBox.size.height}', name: 'RATE BAR');

        setState(() {
          selectedGrade = 0;
        });

        if (details.localPosition.dy < -35 ) {
          setState(() {
            selectedGrade = 1;
          });
        }

        if (details.localPosition.dy < -100 ) {
          setState(() {
            selectedGrade = 2;
          });
        }

        if (details.localPosition.dy < -140 ) {
          setState(() {
            selectedGrade = 3;
          });
        }

        if (details.localPosition.dy < -240 ) {
          setState(() {
            selectedGrade = 4;
          });
        }

        if (details.localPosition.dy < -330 ) {
          setState(() {
            selectedGrade = 5;
          });
        }
      },
      child: Container(
        key: _rateContainerKey,
        decoration: const BoxDecoration(
          color: Colors.grey, // Background color of the container
          borderRadius: BorderRadius.all(Radius.circular(70)),
        ),
        child: Column(
          children: [
            _grades(),
            SvgPicture.asset(
              width: 70,
              'assets/rate_btn.svg'
            ),
          ],
        ),
      ),
    );
  }

  Widget _grades() {
    const double margin = 10;

    if (showGrades) {
      return Column(
        children: [
          _grade(5, selectedGrade >= 5),
          const SizedBox(height: margin,),
          _grade(4, selectedGrade >= 4),
          const SizedBox(height: margin,),
          _grade(3, selectedGrade >= 3),
          const SizedBox(height: margin,),
          _grade(2, selectedGrade >= 2),
          const SizedBox(height: margin,),
          _grade(1, selectedGrade >= 1),
          const SizedBox(height: margin,),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  _grade(int no, bool selected) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.green, // Background color of the container
        shape: BoxShape.circle, // Makes the container circular
      ),
      child: Center(child: Text(no.toString(), style: const TextStyle(fontSize: 20, color: Colors.black),)),
    );
  }
}