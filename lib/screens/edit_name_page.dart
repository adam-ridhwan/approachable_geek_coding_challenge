import 'package:flutter/material.dart';
import 'package:flutter_learn_the_basics/widgets/custom_edit_page_header.dart';
import 'package:flutter_learn_the_basics/widgets/custom_input_field.dart';
import 'package:flutter_learn_the_basics/widgets/custom_update_button.dart';

class EditNamePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final Function(String, String) updateName;

  const EditNamePage({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.updateName,
  }) : super(key: key);

  @override
  _EditNamePageState createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    firstNameController.dispose();
    lastNameController.dispose();
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

      // Update the name

      // Retrieve values from the controllers
      String updatedFirstName = firstNameController.text;
      String updatedLastName = lastNameController.text;

      // Update the name
      widget.updateName(updatedFirstName, updatedLastName);
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
            const CustomEditPageHeader(text: "What's your name?"),
            const SizedBox(height: 35),
            Form(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CustomInputField(
                        label: 'First Name',
                        controller: firstNameController,
                        focusNode: firstNameFocusNode,
                        isLoading: isLoading,
                      ),
                      const SizedBox(width: 16),
                      CustomInputField(
                        label: 'Last Name',
                        controller: lastNameController,
                        focusNode: lastNameFocusNode,
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
