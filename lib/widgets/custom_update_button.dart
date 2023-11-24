import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

class CustomGlowButton extends StatelessWidget {
  final String buttonText;
  final bool isLoading;
  final VoidCallback onPressed;

  const CustomGlowButton({
    Key? key,
    required this.buttonText,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: GlowButton(
        disableColor: Colors.grey.shade700,
        color: Colors.black,
        borderRadius: BorderRadius.zero,
        onPressed: isLoading ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              buttonText,
              style: const TextStyle(
                letterSpacing: -0.5,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
