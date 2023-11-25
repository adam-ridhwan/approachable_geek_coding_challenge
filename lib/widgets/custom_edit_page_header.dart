import 'package:flutter/material.dart';

/// A custom widget that displays a header text for an edit page.
///
/// It is designed to be reusable across different edit screens where a styled header text is
/// needed.The style is consistent and suitable for headers, making the text prominent
/// and easily readable.
///
/// Usage Example:
/// ```
/// CustomEditPageHeader(
///   text: 'Profile Settings',
/// );
/// ```
///
/// Parameters:
/// - [String text]: The text to be displayed as the header. This is a required
///   parameter and it determines the content of the header.
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
