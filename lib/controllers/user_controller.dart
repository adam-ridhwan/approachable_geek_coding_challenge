import 'package:flutter_learn_the_basics/models/user.dart';

class UserController {
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
        user.phone = value;
        break;
      case 'bio':
        user.bio = value;
        break;
      case 'image':
        user.image = value;
    }
  }

  void updateAttributes(Map<String, String> updates) {
    updates.forEach((key, value) {
      updateAttribute(key, value);
    });
  }
}
