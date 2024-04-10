import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/src/features/authentication/screens/login/sign_in.dart';
import 'package:dashboard/src/main_screen.dart';
import 'package:dashboard/src/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:dashboard/src/utils/exceptions/firebase_exceptions.dart';
import 'package:dashboard/src/utils/exceptions/format_exceptions.dart';
import 'package:dashboard/src/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// 1.  Variables.

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Get authenticated user Data.
  User? get authUser => _auth.currentUser;
  // final userController = Get.put(UserController());
  // final userRepository = Get.put(UserRepository());

  /// Called from main.dart on app launch.
  @override
  void onReady() {
    /// 1. remove the splash screen.
    // checkMaintenanceMode();

    // FlutterNativeSplash.remove();
    screenRedirect();

    /// 2. call screenRedirect fn.
    // checkMaintenanceMode().then(
    //   (exists) {
    //     if (exists) {
    //       Get.offAll(() => MaintenancePage()); // Document exists
    //     } else {
    //       screenRedirect(); // Document does not exist
    //     }
    //   },
    // );
  }

  void screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        print("screenredirect.." + authUser.toString());
        Get.offAll(() => MainScreen());
      } else {
        Get.offAll(() => SignIn());
      }
    } else {
      //Local Storage
      deviceStorage.writeIfNull("IsFirstTime", true);
      deviceStorage.read("IsFirstTime") != true
          ? Get.offAll(() => const SignIn())
          : Get.offAll(() => const SignIn());
    }
  }

  /* ----------------------------------- Federated identity & social sign-in -----------------------------------*/
  /// [GoogleAuthentication] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider authProvider = GoogleAuthProvider();
        try {
          final UserCredential userCredential =
              await _auth.signInWithPopup(authProvider);

          return userCredential;
        } on FirebaseAuthException catch (e) {
          throw TFirebaseAuthException(e.code).message;
        } on FirebaseException catch (e) {
          throw TFirebaseException(e.code).message;
        } on FormatException catch (_) {
          throw const TFormatException();
        } on PlatformException catch (e) {
          throw TPlatformException(e.code).message;
        } catch (e) {
          if (kDebugMode) print('Something went wrong: $e');
          return null;
        }
      } else {
        // Trigger the authentication flow
        final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

        //Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await userAccount?.authentication;

        //Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        //once signed in , return the user credentials
        return await _auth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

  /* ----------------------------------- LogOut -----------------------------------*/
  /// [LogoutUser] - Valid for any authentication.
  ///
  Future<void> logout() async {
    try {
      Get.offAll(() => const SignIn());
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [DeleteUser] - Remove user Auth and Firestore Account.
}
