import 'package:flutter/cupertino.dart';

class ProfileItem {
  final String label;
  final String text;
  final Widget Function() editPageBuilder;

  ProfileItem({
    required this.label,
    required this.text,
    required this.editPageBuilder,
  });
}
