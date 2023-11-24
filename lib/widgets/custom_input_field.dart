import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isLoading;
  final List<TextInputFormatter>? inputFormatters; // Optional input formatters

  const CustomInputField({
    Key? key,
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.isLoading,
    this.inputFormatters, // Accept input formatters
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(focusNode);
        },
        child: Opacity(
          opacity: isLoading ? 0.5 : 1,
          child: Container(
            height: 70,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    letterSpacing: -0.5,
                    fontSize: 16,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextFormField(
                  enabled: !isLoading,
                  focusNode: focusNode,
                  controller: controller,
                  inputFormatters: inputFormatters,
                  // Use the input formatters
                  decoration: const InputDecoration(
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
