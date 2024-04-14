import 'package:dashboard/src/common/styles/styles/spacing_styles.dart';
import 'package:dashboard/src/common/widgets/login_signup/form_divider.dart';
import 'package:dashboard/src/common/widgets/login_signup/social_buttons.dart';
import 'package:dashboard/src/features/authentication/screens/login/widgets/form_header_widget.dart';
import 'package:dashboard/src/features/authentication/screens/login/widgets/login_form_widget.dart';
import 'package:dashboard/src/utils/constants/imges_string.dart';
import 'package:dashboard/src/utils/constants/sizes.dart';
import 'package:dashboard/src/utils/device/responsive.dart';
import 'package:dashboard/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    // final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                  flex: 2,
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SizedBox()),
            if (Responsive.isTablet(context))
              const Expanded(
                  flex: 1,
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SizedBox()),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Container(
                  padding: TSpacingStyle.paddingWithAppBarHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Logo,title & subTitle
                      FormHeaderWidget(
                          image:
                              dark ? TImages.lightAppLogo : TImages.darkAppLogo,
                          title: "Welcome,",
                          subTitle:
                              "Empowering Mentors to Assess Student Progress and Performance."),

                      /// Form
                      const LoginForm(),

                      /// Divider
                      FormDivider(
                        dark: dark,
                        dividerText: "orSignInWith",
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),

                      //Social Buttons
                      const SocialButtons(),

                      //const LoginFooterWidget(),
                    ],
                  ),
                ),
              ),
            ),
            if (Responsive.isTablet(context))
              const Expanded(
                  flex: 1,
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SizedBox()),
            if (Responsive.isDesktop(context))
              const Expanded(
                  flex: 2,
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
