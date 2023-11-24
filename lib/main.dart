import 'package:flutter/material.dart';
import 'package:flutter_learn_the_basics/screens/edit_name_page.dart';
import 'package:flutter_learn_the_basics/screens/edit_phone_page.dart';
import 'package:flutter_learn_the_basics/screens/edit_email_page.dart';
import 'package:flutter_learn_the_basics/screens/edit_bio_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String firstName = 'Adam';
  String lastName = 'Ridhwan';
  String phone = '(208) 206-5039';
  String email = 'adamridhwan.1@gmail.com';
  String bio = 'Hi my nma eis Mica Smith. I am from Mesa but go to school in Salt Lake City. \n '
      'I make this drive all the time '
      'and have plenty';

  void updateName(String firstName, String lastName) {
    setState(() {
      this.firstName = firstName;
      this.lastName = lastName;
    });
  }

  void updatePhone(String phone) {
    setState(() {
      this.phone = phone;
    });
  }

  void updateEmail(String email) {
    setState(() {
      this.email = email;
    });
  }

  void updateBio(String bio) {
    setState(() {
      this.bio = bio;
    });
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
              _avatarImage(),
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

  Widget _avatarImage() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.indigoAccent, width: 5.0),
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(radius: 70, backgroundImage: AssetImage('assets/avatar.png')),
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
    );
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
          text: '$firstName $lastName',
          editPageBuilder: () => EditNamePage(
            firstName: firstName,
            lastName: lastName,
            updateName: updateName,
          ),
        ),
        ProfileItem(
          label: 'Phone',
          text: phone,
          editPageBuilder: () => EditPhonePage(
            phone: phone,
            updatePhone: updatePhone,
          ),
        ),
        ProfileItem(
          label: 'Email',
          text: email,
          editPageBuilder: () => EditEmailPage(
            email: email,
            updateEmail: updateEmail,
          ),
        ),
        ProfileItem(
          label: 'Tell us about yourself',
          text: bio,
          editPageBuilder: () => EditBioPage(
            bio: bio,
            updateBio: updateBio,
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
