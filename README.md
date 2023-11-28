# Approachable Geek Coding Challenge

This repository contains the source code for the Approachable Geek Coding Challenge by **Adam Ridhwan**.

## Project Description

This project is a coding challenge and the task is to create a profile page, which allows users to navigate to an edit page that allows them to edit their profile information: name, number, email, and bio. Users are also able to edit their profile photo.

## Technology Stack

For this coding challenge, I used Flutter to create the profile page. I had no prior knowledge on Flutter before starting this project. So I had to spend a spend a day to learn the basics. I was able to pick it up pretty quickly and successfully completed the requirements for the coding challenge.

## Getting Started

These instructions will get you a copy of the project up and running on your machine for testing purposes.

### Cloning the Repository

To clone the project, run the following command in the terminal: 

```bash
git clone https://github.com/adam-ridhwan/approachable_geek_coding_challenge.git
```

### Installing Dependencies 

Once the project is cloned, navigate to the project directory and run the following command to install all the 
necessary dependencies:

```bash
cd approachable_geek_coding_challenge
flutter pub get
```

## Usage

Below is an example of how editing each profile attribute works. 

<img src="https://github.com/adam-ridhwan/approachable_geek_coding_challenge/assets/76563028/4f26abbd-d1a6-4a60-9f6f-dfbc384dec6a" alt="usage" height="600">

## Features

Below are some code example on the features I implemented: 

### Profile Picture 

<img src="https://github.com/adam-ridhwan/approachable_geek_coding_challenge/assets/76563028/02bc4412-5dcf-4cf3-93df-743ef883da1a" alt="usage" height="600">






1) I first added an image to the assets folder:


```dart
  assets/avatar.png
```

2) I created an avatar image using `AssetImage`

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

3) 


### Rendering list of profile attributes (name, phone, email, bio)

<img src="https://github.com/adam-ridhwan/approachable_geek_coding_challenge/assets/76563028/ee28fc1a-9a37-49b9-ae89-32ce277855cb" alt="usage" height="200">

###

1) Firstly, I created a class that holds the label, text(value of attribute), the view of the corresponding attribute:

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

2) I created a `List` that holds all of the attributes.

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

3) I created a `container Widget` that maps over the list to create tappable `child Widgets`.

```dart
  Widget _editProfileList(BuildContext context) {
    List<ProfileItem> items = editProfileAttributes(context);

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(children: items.map((item) => _editProfileItem(context, item)).toList()),
    );
  }
```

4) Tapping on the `child Widgets` (profile attribute - name, phone, email, bio) will navigate to its corresponding edit view.

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











