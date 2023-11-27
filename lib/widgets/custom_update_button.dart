import 'package:approachable_geek_coding_challenge/controllers/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

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
///   and shows the loading text. If false, it functions as a normal button.
/// - [VoidCallback onPressed]: The callback function that is called when the button
///   is pressed. This is required unless `isLoading` is true.
///
/// Example usage:
/// ```
/// CustomUpdateButton(
///   isLoading: _isLoading,
///   onPressed: _handleUpdate,
/// );
/// ```
class CustomUpdateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomUpdateButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadingController = Provider.of<LoadingController>(context);

    return SizedBox(
      width: double.infinity,
      height: 60,
      child: GlowButton(
        disableColor: Colors.grey.shade700,
        color: Colors.black,
        borderRadius: BorderRadius.zero,
        onPressed: loadingController.isLoading ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            loadingController.isLoading
                ? const SpinKitPulse(
                    color: Colors.white,
                    size: 30.0,
                  )
                : Container(),
            Text(
              loadingController.isLoading ? 'Updating...' : 'Update',
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
