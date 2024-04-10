import 'package:dashboard/src/common/widgets/loaders/animation_loader.dart';
import 'package:dashboard/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// A utility class for managing a full-screen loading dialog.
class TFullScreenLoader {
  /// Open a full-screen loading dialog with a given text and animation.
  // This method doesn't return anything.
  /// Parameters:
  /// - text: The text to be displayed in the loading dialog.
  /// - animation: The Lottie animation to be shown.
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: double.infinity, // Adjust the width as needed
          height: double.infinity, // Adjust the height as needed
          decoration: BoxDecoration(
            color: THelperFunctions.isDarkMode(Get.context!)
                ? Colors.black.withOpacity(0.2)
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Wait....",
                style: TextStyle(fontSize: 50),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // stop loading animation , does not return anything
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
