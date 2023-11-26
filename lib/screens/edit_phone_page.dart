import 'package:approachable_geek_coding_challenge/utilities/update_profile_attribute_utility.dart';
import 'package:approachable_geek_coding_challenge/widgets/custom_edit_page_header.dart';
import 'package:approachable_geek_coding_challenge/widgets/custom_input_field.dart';
import 'package:approachable_geek_coding_challenge/widgets/custom_update_button.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditPhonePage extends StatefulWidget {
  final String phone;

  const EditPhonePage({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  _EditPhonePageState createState() => _EditPhonePageState();
}

class _EditPhonePageState extends State<EditPhonePage> {
  late TextEditingController phoneController;

  final FocusNode phoneFocusNode = FocusNode();

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
    super.dispose();
    phoneController.dispose();
  }

  void _handleUpdatePhone(BuildContext context) {
    UpdateProfileAttributeUtility.updateProfileAttribute(context, {
      'phone': phoneController.text,
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 300),
                  CustomGlowButton(onPressed: () => _handleUpdatePhone(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
