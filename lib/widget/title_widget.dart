import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String text;

  const TitleWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      fontSize: 42,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    textAlign: TextAlign.center,
  );
}

class TitleImageWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const TitleImageWidget({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Icon(icon, size: 100, color: Colors.white),
      const SizedBox(height: 16),
      Text(
        text,
        style: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}