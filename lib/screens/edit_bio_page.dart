import 'package:approachable_geek_coding_challenge/utilities/update_profile_attribute_utility.dart';
import 'package:approachable_geek_coding_challenge/widgets/custom_edit_page_header.dart';
import 'package:approachable_geek_coding_challenge/widgets/custom_input_field.dart';
import 'package:approachable_geek_coding_challenge/widgets/custom_update_button.dart';
import 'package:flutter/material.dart';

class EditBioPage extends StatefulWidget {
  final String bio;

  const EditBioPage({
    Key? key,
    required this.bio,
  }) : super(key: key);

  @override
  _EditBioPageState createState() => _EditBioPageState();
}

class _EditBioPageState extends State<EditBioPage> {
  late TextEditingController bioController;

  final FocusNode bioFocusNode = FocusNode();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    bioController = TextEditingController(text: widget.bio);
  }

  @override
  void dispose() {
    super.dispose();
    bioController.dispose();
  }

  void _handleUpdateBio(BuildContext context) {
    UpdateProfileAttributeUtility.updateProfileAttribute(context, {
      'bio': bioController.text,
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
            const CustomEditPageHeader(text: "What type of passenger are you?"),
            const SizedBox(height: 35),
            Form(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CustomInputField(
                        hintText: 'Write a little bit about yourself. Do you like chatting? Are '
                            'you a smoker? Do you bring pets with you? Etc.',
                        minLines: 5,
                        maxLines: 5,
                        controller: bioController,
                        focusNode: bioFocusNode,
                      ),
                    ],
                  ),
                  const SizedBox(height: 180),
                  CustomGlowButton(onPressed: () => _handleUpdateBio(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
