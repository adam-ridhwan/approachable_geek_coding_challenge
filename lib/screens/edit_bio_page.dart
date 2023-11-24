import 'package:flutter/material.dart';
import 'package:flutter_learn_the_basics/widgets/custom_edit_page_header.dart';
import 'package:flutter_learn_the_basics/widgets/custom_input_field.dart';
import 'package:flutter_learn_the_basics/widgets/custom_update_button.dart';

class EditBioPage extends StatefulWidget {
  final String bio;
  final Function(String) updateBio;

  const EditBioPage({
    Key? key,
    required this.bio,
    required this.updateBio,
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

  void _handleUpdateBio(BuildContext context) async {
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

      // Update the bio
      widget.updateBio(bioController.text);
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
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                  const SizedBox(height: 180),
                  CustomGlowButton(
                      isLoading: isLoading, onPressed: () => _handleUpdateBio(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
