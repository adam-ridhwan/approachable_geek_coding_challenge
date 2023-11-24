import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isLoading;
  final int? minLines;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const CustomInputField({
    Key? key,
    this.label,
    this.hintText,
    required this.controller,
    required this.focusNode,
    required this.isLoading,
    this.minLines,
    this.maxLines,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(focusNode),
        child: Opacity(
          opacity: isLoading ? 0.5 : 1,
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
                  enabled: !isLoading,
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
