import 'package:approachable_geek_coding_challenge/controllers/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/// A custom input field widget for user text input.
///
/// This widget is designed to provide a customizable text input field with optional
/// label and hint text. It supports multiline input and can be formatted with custom
/// text input formatters. The widget can also show a loading state, which disables
/// the input and reduces its opacity.
///
/// Parameters:
/// - [String? label]: An optional label displayed above the text field. If null, no label is shown.
/// - [String? hintText]: An optional hint text displayed within the text field when it is empty.
/// - [TextEditingController controller]: The controller for the text field. Required.
/// - [FocusNode focusNode]: The focus node for the text field. Required.
/// - [int? minLines]: The minimum number of lines for the text field. Defaults to 1.
/// - [int? maxLines]: The maximum number of lines for the text field. Defaults to 1.
/// - [List<TextInputFormatter>? inputFormatters]: Optional input formatters.
///
/// Example usage:
/// ```
/// CustomInputField(
///   label: 'Username',
///   hintText: 'Enter your username',
///   controller: _usernameController,
///   focusNode: _usernameFocusNode,
///   isLoading: _isLoading,
///   minLines: 1,
///   maxLines: 3,
///   inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[ ]'))], // Example formatter
/// );
/// ```
class CustomInputField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final int? minLines;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const CustomInputField({
    Key? key,
    this.label,
    this.hintText,
    required this.controller,
    required this.focusNode,
    this.minLines,
    this.maxLines,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadingController = Provider.of<LoadingController>(context);

    return Expanded(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(focusNode),
        child: Opacity(
          opacity: loadingController.isLoading ? 0.5 : 1,
          child: Container(
            // height: 70,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                label != null
                    ? Text(
                        label!,
                        style: TextStyle(
                          letterSpacing: -0.5,
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : Container(),
                TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: minLines ?? 1,
                  maxLines: maxLines ?? 1,
                  enabled: !loadingController.isLoading,
                  focusNode: focusNode,
                  controller: controller,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      letterSpacing: -0.5,
                      fontSize: 16,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w700,
                    ),
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(
                    letterSpacing: -0.5,
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
