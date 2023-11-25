import 'package:approachable_geek_coding_challenge/models/user.dart';
import 'package:flutter/foundation.dart';

class UserController extends ChangeNotifier {
  final User user;

  UserController(this.user);

  /// Updates the attributes of a user object.
  ///
  /// This function takes a key-value pair and updates the corresponding attribute
  /// of a user object based on the provided key. The function supports updating
  /// various user attributes including first name, last name, phone number, email,
  /// bio, and image URL.
  ///
  /// Note: There is a likely bug in the 'email' case where the phone attribute is
  /// being updated instead of the email.
  ///
  /// Example Usage:
  /// ```dart
  /// updateAttribute('firstName', 'John');
  /// updateAttribute('email', 'john@example.com');
  /// ```
  ///
  /// Parameters:
  ///   [String] key - The key corresponding to the user attribute to be updated.
  ///                  Accepted values are 'firstName', 'lastName', 'phone',
  ///                  'email', 'bio', and 'image'.
  ///   [String] value - The new value to assign to the user attribute.
  ///
  /// No return value.
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
