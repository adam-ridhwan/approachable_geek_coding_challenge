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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: <Widget>[
          const SizedBox(height: 20),
          _headerText(),
          _listTile(),
          const SizedBox(height: 30),
          Builder(builder: (context) {
            return _buildListTile(
              label: 'Name',
              text: '$firstName $lastName',
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          EditNamePage(
                            firstName: firstName,
                            lastName: lastName,
                            updateName: updateName,
                          ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200)),
                );
              },
            );
          }),
          Builder(builder: (context) {
            return _buildListTile(
              label: 'Phone',
              text: phone,
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          EditPhonePage(phone: phone, updatePhone: updatePhone),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200)),
                );
              },
            );
          }),
          Builder(builder: (context) {
            return _buildListTile(
              label: 'Email',
              text: email,
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          EditEmailPage(email: email, updateEmail: updateEmail),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200)),
                );
              },
            );
          }),
          Builder(builder: (context) {
            return _buildListTile(
              label: 'Tell us about yourself',
              text: 'Hi my name is Micah Smith. I am from Mesa but go to '
                  'school in Salt Lake City. \n I make this drive all the time '
                  'and have 5plenty',
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const EditBioPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200)),
                );
              }, // Handle bio edit
            );
          }),
        ]),
      )),
    );
  }

  /// ────────────────────────────────────────────────────────────
  /// Edit profile text
  /// ────────────────────────────────────────────────────────────
  Widget _headerText() {
    return Container(
      margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
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

  /// ────────────────────────────────────────────────────────────
  /// Avatar image
  /// ────────────────────────────────────────────────────────────
  Widget _listTile() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.indigoAccent,
                width: 5.0, // Border width
              ),
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(''),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit, color: Colors.indigoAccent),
            ),
          ),
        ],
      ),
    );
  }

  /// ────────────────────────────────────────────────────────────
  /// Inputs
  /// ────────────────────────────────────────────────────────────
  Widget _buildListTile({
    required String label,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            // Adjust color and thickness as needed
            width: 1.0,
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      text,
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
              Icon(Icons.arrow_forward_ios,
                  color: Colors.grey.shade400, size: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
