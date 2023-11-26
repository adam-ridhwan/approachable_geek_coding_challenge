import 'package:approachable_geek_coding_challenge/utilities/update_profile_attribute_utility.dart';
import 'package:approachable_geek_coding_challenge/widgets/custom_edit_page_header.dart';
import 'package:approachable_geek_coding_challenge/widgets/custom_input_field.dart';
import 'package:approachable_geek_coding_challenge/widgets/custom_update_button.dart';
import 'package:flutter/material.dart';

class EditNamePage extends StatefulWidget {
  final String firstName;
  final String lastName;

  const EditNamePage({
    Key? key,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  @override
  _EditNamePageState createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }

  void _handleUpdateName(BuildContext context) {
    UpdateProfileAttributeUtility.updateProfileAttribute(context, {
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
    });
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
                      ),
                      const SizedBox(width: 16),
                      CustomInputField(
                        label: 'Last Name',
                        controller: lastNameController,
                        focusNode: lastNameFocusNode,
                      ),
                    ],
                  ),
                  const SizedBox(height: 300),
                  CustomGlowButton(onPressed: () => _handleUpdateName(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
