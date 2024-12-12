import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, this.scaling = 1.0});
  final double iconSize = 30;
  final iconColor = Colors.white;
  final double scaling;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _build_button_1(),
        _build_calendar_button(),
        _build_button_3(),
        _build_notifications_button(),
        _build_profile_button(),
      ],
    );
  }

  _build_button_1() {
    return IconButton(
        onPressed: () {},
        iconSize: iconSize * scaling,
        icon: const Icon(Icons.local_fire_department), color: iconColor,);
  }


  _build_calendar_button() {
    return IconButton(
      onPressed: () {},
      iconSize: iconSize * scaling,
      icon: const Icon(Icons.calendar_month), color: iconColor);
  }

  _build_button_3() {
    return IconButton(
        onPressed: () {},
        iconSize: iconSize * scaling,
        icon: const Icon(Icons.outbox_outlined), color: iconColor);
  }

  _build_notifications_button() {
    return IconButton(
        onPressed: () {},
        iconSize: iconSize * scaling,
        icon: const Icon(Icons.notifications), color: iconColor);
  }

  _build_profile_button() {
    return IconButton(
        onPressed: () {},
        iconSize: iconSize * scaling,
        icon: const Icon(Icons.account_box), color: iconColor);
  }
}