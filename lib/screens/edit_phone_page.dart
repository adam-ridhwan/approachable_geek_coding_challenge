import 'package:flutter/material.dart';
import 'package:flutter_learn_the_basics/widgets/custom_edit_page_header.dart';
import 'package:flutter_learn_the_basics/widgets/custom_input_field.dart';
import 'package:flutter_learn_the_basics/widgets/custom_update_button.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditPhonePage extends StatefulWidget {
  final String phone;
  final Function(String) updatePhone;

  const EditPhonePage({Key? key, required this.phone, required this.updatePhone}) : super(key: key);

  @override
  _EditPhonePageState createState() => _EditPhonePageState();
}

class _EditPhonePageState extends State<EditPhonePage> {
  late TextEditingController phoneController;

  final FocusNode phoneFocusNode = FocusNode();

  bool isLoading = false;

  final maskFormatter = MaskTextInputFormatter(
    mask: '(###) ###-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(text: widget.phone);
    // Apply the mask to the existing phone number if any
    maskFormatter.formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: widget.phone),
    );
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    phoneController.dispose();
    super.dispose();
  }

  void _handleUpdateName(BuildContext context) async {
    if (!mounted) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Simulate a delay
      await Future.delayed(const Duration(seconds: 2));

      // Check if the widget is still mounted before updating
      if (!mounted) {
        return;
      }

      // Update the phone
      widget.updatePhone(phoneController.text);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      // Check if the widget is still mounted before navigating
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 25),
            const CustomEditPageHeader(text: "What's your phone number?"),
            const SizedBox(height: 35),
            Form(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CustomInputField(
                        label: 'Your phone number',
                        inputFormatters: [maskFormatter],
                        controller: phoneController,
                        focusNode: phoneFocusNode,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                  const SizedBox(height: 300),
                  CustomGlowButton(
                      isLoading: isLoading,
                      onPressed: () {
                        _handleUpdateName(context);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
