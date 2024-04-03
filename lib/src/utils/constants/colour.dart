import 'package:flutter/material.dart';

/* -- List of all colors --*/

const tPrimaryColor = const Color.fromARGB(213, 98, 1, 136);

const tbaseColoe = Color.fromARGB(177, 146, 143, 189); // -- HOMEPAGE COLORS
const tHomePageGradientStartColor = Color(0xFFB4E0FF);
const tHomePageGradientEndColor = Color(0xFFF3D0FF);
const tHomePageBackgroundColor2 = Color.fromRGBO(255, 255, 255, 1);
const tHomePageBackgroundColor3 = Colors.transparent;
final tHomePageColor4 = Color(0xFFffffff);

// -- HomeScreen
//1. container colors
const tRentReceived = Color.fromRGBO(229, 214, 255, 1);
const tRentDefaulter = Color.fromRGBO(241, 243, 250, 1);
const tDepositReceived = Color.fromRGBO(245, 252, 250, 1);
// const tPendingSettlement = Color.fromRGBO(255, 225, 220, 0.3);
const tPendingSettlement = tRentDefaulter;
// const tPendingDues = Color.fromRGBO(253, 239, 212, 0.3);
const tPendingDues = tDepositReceived;
const tSubscription = Color.fromRGBO(245, 224, 187, 1);
//2. text colors
const tSubscriptionTitle = Colors.black; // Color.fromRGBO(218, 170, 121, 1);

// --ProfilePage
const tPencilColor = tRentReceived;
const tEditProfileButtonColor = tRentReceived;
const tEditProfileButtonTextColor = Colors.black;
const tmenuIconColorLight = const Color.fromARGB(213, 98, 1, 136);
const tmenuIconColorDark = const Color.fromARGB(213, 98, 1, 136);
const tmenuIconsContainerColor = tSubscription;
const tmenuTextColor = Colors.black;

// -- Update Profile Screen

// -- universal border radius
final tdefaultGradient = LinearGradient(
  colors: [
    // category.color.withOpacity(0.55),
    // category.color.withOpacity(0.9),
    Color.fromRGBO(234, 141, 141, 1).withOpacity(0.5),
    Color.fromRGBO(168, 144, 254, 1).withOpacity(0.5),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final tforeground = Color.fromRGBO(234, 141, 141, 1).withOpacity(0.5);
final tbackground = Color.fromRGBO(168, 144, 254, 1).withOpacity(0.5);
final tFloatingActionButtonColor = Color.alphaBlend(tforeground, tbackground);

//people
final textaddcontact = Colors.black;

class TColors {
  // App theme colors
  static const Color primary = Color(0xFF4b68ff);
  static const Color secondary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFb0c7ff);

  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  // Background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = TColors.white.withOpacity(0.1);

  // Button colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);
}
