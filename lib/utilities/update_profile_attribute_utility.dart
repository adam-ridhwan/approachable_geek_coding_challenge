import 'package:approachable_geek_coding_challenge/controllers/loading_controller.dart';
import 'package:approachable_geek_coding_challenge/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common_functions.dart';

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
