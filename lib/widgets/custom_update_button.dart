import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

/// A custom glowing button widget with loading state support.
///
/// This widget creates a button with a glow effect that can indicate a loading
/// state. When in a loading state, the button displays a 'Updating...' text and
/// becomes disabled. Otherwise, it shows the 'Update' text and can be pressed.
///
/// The button is designed to take up the full width of its container and has a
/// fixed height. The glow effect and colors are managed by the `GlowButton` widget
/// from the `flutter_glow` package.
///
/// Parameters:
/// - [bool isLoading]: Determines the button's state. If true, the button is disabled
///   and shows the loading text. If false, it functions as a normal button.
/// - [VoidCallback onPressed]: The callback function that is called when the button
///   is pressed. This is required unless `isLoading` is true.
///
/// Example usage:
/// ```
/// CustomGlowButton(
///   isLoading: _isLoading,
///   onPressed: _handleUpdate,
/// );
/// ```
class CustomGlowButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const CustomGlowButton({
    Key? key,
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
              isLoading ? 'Updating...' : 'Update',
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
