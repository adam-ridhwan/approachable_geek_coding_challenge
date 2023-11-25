import 'package:flutter/material.dart';
import 'package:flutter_learn_the_basics/controllers/user_controller.dart';
import 'package:flutter_learn_the_basics/models/profile_item.dart';
import 'package:flutter_learn_the_basics/models/user.dart';
import 'package:flutter_learn_the_basics/screens/edit_bio_page.dart';
import 'package:flutter_learn_the_basics/screens/edit_email_page.dart';
import 'package:flutter_learn_the_basics/screens/edit_name_page.dart';
import 'package:flutter_learn_the_basics/screens/edit_phone_page.dart';
import 'package:flutter_learn_the_basics/screens/edit_photo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final UserController userController;

  // Initialize User
  @override
  void initState() {
    super.initState();
    userController = UserController(
      User(
        firstName: 'Adam',
        lastName: 'Ridhwan',
        phone: '(208) 206-5039',
        email: 'adamridhwan.1@gmail.com',
        bio: 'Hi my name is Adam Ridhwan. I like playing badminton and eating good food.',
        image: 'assets/avatar.png',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              _headerText(),
              _avatarImage(context),
              _editProfileList(context),
            ],
          ),
        ),
      ),
    );
  }

  // Updates the User attributes
  void updateUserProfile(Map<String, String> updates) {
    setState(() => userController.updateAttributes(updates));
  }

  /// Creates a header text widget for the profile editing screen.
  ///
  /// Returns a [Widget] that displays the styled header text for the profile editing screen.
  Widget _headerText() {
    return Container(
      margin: const EdgeInsets.only(top: 50.0, bottom: 20.0),
      child: const Center(
        child: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 25,
            color: Colors.indigoAccent,
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
          ),
        ),
      ),
    );
  }

  /// Creates an avatar image widget with an edit icon that allows users to tap on the avatar,
  /// which navigates the user to the corresponding edit page.
  ///
  /// The [context] parameter is the build context for the widget. It is used to handle
  /// navigation when the avatar is tapped.
  ///
  /// Returns a [Widget] that displays the user's avatar image with an edit icon.
  Widget _avatarImage(BuildContext context) {
    return Builder(builder: (context) {
      return Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => EditPhotoPage(
                  image: userController.user.image,
                  updateUserProfile: (String newImage) {
                    updateUserProfile({'image': newImage});
                  },
                ),
                transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(milliseconds: 200),
              ),
            );
          },
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigoAccent, width: 5.0),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                    radius: 70, backgroundImage: AssetImage(userController.user.image)),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.edit, color: Colors.indigoAccent),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Builds a list of tappable containers for editing user profile attributes.
  ///
  /// Iterates through `profileEditOptions` to create a list of widgets, each representing
  /// an editable profile attribute. Tapping on an item navigates the user to the corresponding
  /// edit page for that attribute.
  ///
  /// This widget is typically used in a user profile editing screen where multiple
  /// attributes (like name, phone, email, etc.) can be edited.
  ///
  /// The [context] parameter is the build context for the widget and is used to
  /// navigate to different editing screens when an item is tapped.
  ///
  /// Returns a [Widget] that displays a column of tappable profile attribute items.
  Widget _editProfileList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: profileEditOptions.map((item) => _editProfileItem(context, item)).toList(),
      ),
    );
  }

  /// Creates a tappable container for a profile item.
  ///
  /// This widget is used to display an editable profile attribute, such as
  /// name, phone, or email, etc. Tapping on the container navigates the user
  /// to the corresponding edit page for that attribute.
  ///
  /// The [context] parameter provides the build context for the widget.
  /// The [item] parameter contains the data for the profile attribute,
  /// including its label, current value, and the builder function for
  /// its edit page.
  ///
  /// Returns a [Widget] that represents a styled, tappable container
  /// for editing a profile attribute.
  ///
  /// Example:
  /// ```
  /// _editProfileItem(context, ProfileItem(
  ///   label: 'Name',
  ///   text: 'John Doe',
  ///   editPageBuilder: () => EditNamePage(...),
  /// ));
  /// ```
  Widget _editProfileItem(BuildContext context, ProfileItem item) {
    return Builder(builder: (context) {
      return Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.0)),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => item.editPageBuilder(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(milliseconds: 200),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        item.text,
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400, size: 20.0),
              ],
            ),
          ),
        ),
      );
    });
  }

  // List of ProfileItem objects for editing user profile attributes.
  // Each item includes a label for display, current text value, and a builder for the edit page.
  List<ProfileItem> get profileEditOptions => [
        ProfileItem(
          label: 'Name',
          text: '${userController.user.firstName} ${userController.user.lastName}',
          editPageBuilder: () => EditNamePage(
            firstName: userController.user.firstName,
            lastName: userController.user.lastName,
            updateUserProfile: (String newFirstName, String newLastName) {
              updateUserProfile({'firstName': newFirstName, 'lastName': newLastName});
            },
          ),
        ),
        ProfileItem(
          label: 'Phone',
          text: userController.user.phone,
          editPageBuilder: () => EditPhonePage(
            phone: userController.user.phone,
            updateUserProfile: (String newPhone) {
              updateUserProfile({'phone': newPhone});
            },
          ),
        ),
        ProfileItem(
          label: 'Email',
          text: userController.user.email,
          editPageBuilder: () => EditEmailPage(
            email: userController.user.email,
            updateUserProfile: (String newEmail) {
              updateUserProfile({'email': newEmail});
            },
          ),
        ),
        ProfileItem(
          label: 'Tell us about yourself',
          text: userController.user.bio,
          editPageBuilder: () => EditBioPage(
            bio: userController.user.bio,
            updateUserProfile: (String newBio) {
              updateUserProfile({'bio': newBio});
            },
          ),
        ),
      ];
}
