import 'package:flutter/material.dart';

class CustomEditPageHeader extends StatelessWidget {
  final String text;

  const CustomEditPageHeader({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.w700,
        letterSpacing: -1,
      ),
    );
  }
}
