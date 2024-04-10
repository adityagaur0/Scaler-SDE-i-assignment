import 'dart:async';

import 'package:dashboard/src/data/authentication_repository/authentication_repository.dart';
import 'package:dashboard/src/features/core/controllers/user_controller/user_controller.dart';
import 'package:dashboard/src/utils/constants/imges_string.dart';
import 'package:dashboard/src/utils/helpers/network_manager.dart';
import 'package:dashboard/src/utils/popups/full_screen_loader.dart';
import 'package:dashboard/src/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // variables
  final rememberMe = false.obs;
  final hidePassword = true.obs; // observable to hide and showpassword.
  final localStorage = GetStorage();
  final email = TextEditingController(); //controller for email input
  final password = TextEditingController(); //controller for password input
  GlobalKey<FormState> loginformKey =
      GlobalKey<FormState>(); //form key for form validation
  final userController = Get.put(UserController());

  @override
  void onInit() {
    // Read email and password from local storage
    String? rememberedEmail = localStorage.read('REMEMBER_ME_EMAIL');
    String? rememberedPassword = localStorage.read('REMEMBER_ME_PASSWORD');

    // Check if email is not null before assigning to email.text
    if (rememberedEmail != null) {
      email.text = rememberedEmail;
    }

    // Check if password is not null before assigning to password.text
    if (rememberedPassword != null) {
      password.text = rememberedPassword;
    }

    super.onInit();
  }

  /// -- Google SignIn Authentication
  Future<void> googleSignIn() async {
    try {
      // 1. Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.docerAnimation);

      // 2. Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // 3. Google Authentication
      final userCredential =
          await AuthenticationRepository.instance.signInWithGoogle();

      // print(userCredential!.user!.displayName);
      // print(AuthenticationRepository.instance.authUser);

      // 4 . save User record
      await userController.saveUserRecord(userCredential);

      // 5 . remove loader
      TFullScreenLoader.stopLoading();

      //6. Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
