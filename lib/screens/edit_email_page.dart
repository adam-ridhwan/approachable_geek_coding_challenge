import 'package:flutter/material.dart';
import 'package:flutter_learn_the_basics/widgets/custom_edit_page_header.dart';
import 'package:flutter_learn_the_basics/widgets/custom_input_field.dart';
import 'package:flutter_learn_the_basics/widgets/custom_update_button.dart';

class EditEmailPage extends StatefulWidget {
  final String email;
  final Function(String email) updateEmail;

  const EditEmailPage({
    Key? key,
    required this.email,
    required this.updateEmail,
  }) : super(key: key);

  @override
  _EditEmailPageState createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  late TextEditingController emailController;

  final FocusNode emailFocusNode = FocusNode();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  bool emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return false;
    }
    return true;
  }

  void _handleUpdateName(BuildContext context) async {
    if (!emailValidator(emailController.text)) {
      return;
    }

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

      // Update the email
      widget.updateEmail(emailController.text);
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
            const CustomEditPageHeader(text: "What's your email?"),
            const SizedBox(height: 35),
            Form(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CustomInputField(
                        label: 'Your email address',
                        controller: emailController,
                        focusNode: emailFocusNode,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                  const SizedBox(height: 300),
                  CustomGlowButton(
                      buttonText: isLoading ? 'Updating...' : 'Update',
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
