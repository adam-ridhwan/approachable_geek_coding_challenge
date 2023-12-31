import 'package:approachable_geek_coding_challenge/constants/edit_profile_attributes.dart';
import 'package:approachable_geek_coding_challenge/controllers/user_controller.dart';
import 'package:approachable_geek_coding_challenge/models/profile_item.dart';
import 'package:approachable_geek_coding_challenge/models/user.dart';
import 'package:approachable_geek_coding_challenge/screens/edit_photo_page.dart';
import 'package:approachable_geek_coding_challenge/controllers/loading_controller.dart';
import 'package:approachable_geek_coding_challenge/utilities/navigate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoadingController()),
        ChangeNotifierProvider(
          create: (context) => UserController(
            User(
              firstName: 'Adam',
              lastName: 'Ridhwan',
              phone: '(208) 206-5039',
              email: 'adamridhwan.1@gmail.com',
              bio: 'Hi my name is Adam Ridhwan. I like playing badminton and eating good food.',
              image: 'assets/avatar.png',
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    final userController = Provider.of<UserController>(context);

    return Builder(builder: (context) {
      return Center(
        child: InkWell(
          onTap: () => navigate(context, EditPhotoPage(image: userController.user.image)),
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
  /// Iterates through `editProfileAttributes` to create a list of widgets, each representing
  /// an editable profile attribute. Tapping on an item navigates the user to the corresponding
  /// edit page for that attribute.
  ///
  /// Returns a [Widget] that displays a column of tappable profile attribute items.
  Widget _editProfileList(BuildContext context) {
    List<ProfileItem> items = editProfileAttributes(context);

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(children: items.map((item) => _editProfileItem(context, item)).toList()),
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
  Widget _editProfileItem(BuildContext context, ProfileItem item) {
    return Builder(builder: (context) {
      return Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.0)),
        ),
        child: InkWell(
          onTap: () => navigate(context, item.editPageBuilder()),
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
}
