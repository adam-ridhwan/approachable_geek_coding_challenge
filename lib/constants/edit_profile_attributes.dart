import 'package:approachable_geek_coding_challenge/controllers/user_controller.dart';
import 'package:approachable_geek_coding_challenge/models/profile_item.dart';
import 'package:approachable_geek_coding_challenge/screens/edit_bio_page.dart';
import 'package:approachable_geek_coding_challenge/screens/edit_email_page.dart';
import 'package:approachable_geek_coding_challenge/screens/edit_name_page.dart';
import 'package:approachable_geek_coding_challenge/screens/edit_phone_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// List of ProfileItem objects for editing user profile attributes.
// Each item includes a label for display, current text value, and a builder for the edit page.
List<ProfileItem> editProfileAttributes(BuildContext context) {
  final userController = Provider.of<UserController>(context);

  return [
    ProfileItem(
      label: 'Name',
      text: '${userController.user.firstName} ${userController.user.lastName}',
      editPageBuilder: () => EditNamePage(
        firstName: userController.user.firstName,
        lastName: userController.user.lastName,
      ),
    ),
    ProfileItem(
      label: 'Phone',
      text: userController.user.phone,
      editPageBuilder: () => EditPhonePage(
        phone: userController.user.phone,
      ),
    ),
    ProfileItem(
      label: 'Email',
      text: userController.user.email,
      editPageBuilder: () => EditEmailPage(
        email: userController.user.email,
      ),
    ),
    ProfileItem(
      label: 'Tell us about yourself',
      text: userController.user.bio,
      editPageBuilder: () => EditBioPage(
        bio: userController.user.bio,
      ),
    ),
  ];
}
