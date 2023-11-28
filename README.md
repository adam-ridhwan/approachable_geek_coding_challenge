# Approachable Geek Coding Challenge

This repository contains the source code for the Approachable Geek Coding Challenge by **Adam Ridhwan**.

<br>

- [Project Description](#project-description)
- [Technology Stack](#technology-stack)
- [Getting Started](#getting-started)
  - [Cloning the Repository](#1-cloning-the-repository)
  - [Installing Dependencies](#2-installing-dependencies)
- [Usage](#usage)
- [Features](#features)
  - [The Setup](#1-the-setup)
  - [Changing Profile Picture](#2-changing-profile-picture)
  - [Rendering List of Profile Attributes](#3-rendering-list-of-profile-attributes)
- [Utilities](#utilities)
- [Author](#author)


## Project Description

This project is a coding challenge and the task is to create a profile page, which allows users to navigate to an edit page that allows them to edit their profile information: name, number, email, and bio. Users are also able to edit their profile photo.

<br>

## Technology Stack

For this coding challenge, I used Flutter to create the profile page using MVC software pattern. I had no prior knowledge on Flutter before starting this project. So I had to spend a spend a day to learn the basics. I was able to pick it up pretty quickly and was able to completed the requirements for the coding challenge.

<br>

## Getting Started

These instructions will get you a copy of the project up and running on your machine for testing purposes.

### 1) Cloning the Repository

To clone the project, run the following command in the terminal: 

```bash
git clone https://github.com/adam-ridhwan/approachable_geek_coding_challenge.git
```

### 2) Installing Dependencies 

Once the project is cloned, navigate to the project directory and run the following command to install all the 
necessary dependencies:

```bash
cd approachable_geek_coding_challenge
flutter pub get
```

<br>

## Usage

Below is demo of how editing each profile attribute works. 

<div align='center'>
  
  https://github.com/adam-ridhwan/approachable_geek_coding_challenge/assets/76563028/94e3fbd6-f393-482c-aeaf-ec5caf287eb0

</div>

<br>

## Features

Below are some code example on the features I implemented: 

### 1) The setup

1.1) I created the `User` model.

```dart
class User {
  String firstName;
  String lastName;
  String phone;
  String email;
  String bio;
  String image;

  User({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.bio,
    required this.image,
  });
}
```

1.2) I created the `UserController` that handles the updating the `User` model.

```dart
import 'package:approachable_geek_coding_challenge/models/user.dart';
import 'package:flutter/foundation.dart';

class UserController extends ChangeNotifier {
  final User user;

  UserController(this.user);

  void updateAttribute(String key, String value) {
    switch (key) {
      case 'firstName':
        user.firstName = value;
        break;
      case 'lastName':
        user.lastName = value;
        break;
      case 'phone':
        user.phone = value;
        break;
      case 'email':
        user.email = value;
        break;
      case 'bio':
        user.bio = value;
        break;
      case 'image':
        user.image = value;
    }
    notifyListeners();
  }

  void updateAttributes(Map<String, String> updates) {
    updates.forEach((key, value) {
      updateAttribute(key, value);
    });
    notifyListeners();
  }
}
```

1.3) I initialized the default `User` in `main.dart`.

```dart
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
```

<br>

### 2) Changing Profile Picture

<img src="https://github.com/adam-ridhwan/approachable_geek_coding_challenge/assets/76563028/20d52a96-643f-4f25-b3a6-23fe16612256" alt="changing profile picture" height="400">

<br>
<br>

2.1) I first added an image to the assets folder:

```dart
  assets/avatar.png
```

2.2) I created an avatar image using `AssetImage`

<img src="https://github.com/adam-ridhwan/approachable_geek_coding_challenge/assets/76563028/e7a236b7-121b-49f1-9cc8-b9164c3c4015" alt="usage" height="100">

```dart
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
            // ...
            ),
          ],
        ),
      ),
    );
  });
}
```

2.3) Used a library called `image_picker` to pick photos from phone gallery.

```dart
String image = '';

Future<void> _pickImage() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    
    setState(() => this.image = image.path);
  } catch (e) {
    print(e);
  }
}
```

<br>

### 3) Rendering list of profile attributes

<img src="https://github.com/adam-ridhwan/approachable_geek_coding_challenge/assets/76563028/ee28fc1a-9a37-49b9-ae89-32ce277855cb" alt="usage" height="200">

<br>
<br>

3.1) Firstly, I created a class that holds the label, text(value of attribute), the view of the corresponding attribute:

```dart
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
```

3.2) I created a `List` that holds all of the attributes.

```dart
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
    // ...
}
```

3.3) I created a `container Widget` that maps over the list to create tappable `child Widgets`.

```dart
Widget _editProfileList(BuildContext context) {
  List<ProfileItem> items = editProfileAttributes(context);

  return Container(
    padding: const EdgeInsets.all(10),
    child: Column(children: items.map((item) => _editProfileItem(context, item)).toList()),
  );
}
```

3.4) Tapping on the `child Widgets` (profile attribute - name, phone, email, bio) will navigate to its corresponding edit view.

```dart
Widget _editProfileItem(BuildContext context, ProfileItem item) {
  return Builder(builder: (context) {
    return Container(
      child: InkWell(
        onTap: () => navigate(context, item.editPageBuilder()),
      ),
      // ...
    );
  });
}
```

<br>

## Utilities

1) I created a reusable `Navigator` that handles navigation to corresponding edit page, which also has the animation set.

```dart
void navigate(BuildContext context, Widget destinationPage) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(milliseconds: 200),
    ),
  );
```

2) I created a `Utility` function that handles updating the corresponding attribute. 

```dart
class UpdateProfileAttributeUtility {
  static Future<void> updateProfileAttribute(
    BuildContext context,
    Map<String, String> itemsToUpdate,
  ) async {
    final userController = Provider.of<UserController>(context, listen: false);
    final loadingController = Provider.of<LoadingController>(context, listen: false);

    if (!context.mounted) {
      return;
    }

    loadingController.startLoader();

    try {
      await fakeDelay(2);

      if (!context.mounted) {
        return;
      }

      userController.updateAttributes(itemsToUpdate);
    } finally {
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      loadingController.stopLoader();
    }
  }
}
```

3) I created a 'Loading' function & state to handle loading after update function is called.

```dart
import 'package:flutter/material.dart';

class LoadingController with ChangeNotifier {
  bool isLoading = false;

  void startLoader() {
    if (!isLoading) {
      isLoading = true;
      notifyListeners();
    }
  }

  void stopLoader() {
    if (isLoading) {
      isLoading = false;
      notifyListeners();
    }
  }
}
```

<br>

## Author 

- Adam Ridhwan
- www.adamridhwan.com










