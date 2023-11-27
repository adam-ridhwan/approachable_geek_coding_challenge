import 'package:approachable_geek_coding_challenge/utilities/update_profile_attribute_utility.dart';
import 'package:approachable_geek_coding_challenge/widgets/custom_edit_page_header.dart';
import 'package:approachable_geek_coding_challenge/widgets/custom_input_field.dart';
import 'package:approachable_geek_coding_challenge/widgets/custom_update_button.dart';
import 'package:flutter/material.dart';

class EditEmailPage extends StatefulWidget {
  final String email;

  const EditEmailPage({
    Key? key,
    required this.email,
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

  void _handleUpdateEmail(BuildContext context) {
    UpdateProfileAttributeUtility.updateProfileAttribute(context, {
      'email': emailController.text,
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 300),
                  CustomUpdateButton(onPressed: () => _handleUpdateEmail(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
