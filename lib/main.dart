import 'package:flutter/material.dart';
import 'package:flutter_learn_the_basics/controller/user_controller.dart';
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

  void updateUserProfile(Map<String, String> updates) {
    setState(() => userController.updateAttributes(updates));
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

  Widget _avatarImage(BuildContext context) {
    return Builder(builder: (context) {
      return Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    EditPhotoPage(image: userController.user.image),
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

  Widget _editProfileList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: profileEditOptions.map((item) => _editProfileItem(context, item)).toList(),
      ),
    );
  }

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

class ProfileItem {
  final String label;
  final String text;
  final Widget Function() editPageBuilder;

  ProfileItem({
    required this.label,
    required this.text,
    required this.editPageBuilder,
  });
}
