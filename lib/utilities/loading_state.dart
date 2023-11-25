import 'package:flutter/material.dart';

class LoadingState with ChangeNotifier {
  bool isLoading = false;

  // bool get isLoading => _isLoading;

  // void setLoading(bool loading) {
  //   _isLoading = loading;
  //   notifyListeners();
  // }

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
