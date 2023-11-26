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
