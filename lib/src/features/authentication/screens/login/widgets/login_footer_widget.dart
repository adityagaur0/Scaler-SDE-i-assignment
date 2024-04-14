import 'package:flutter/material.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // const SizedBox(
        //   height: tFormHeight - 20,
        // ),
        // TextButton(
        //   onPressed: () {
        //     Get.off(() => const SignUpScreen());
        //     // Navigator.push(
        //     //     context, MaterialPageRoute(builder: (cnt) => SignUpScreen()));
        //   },
        //   child: Text.rich(
        //     TextSpan(
        //         text: tAlreadyHaveAnAccount,
        //         style: Theme.of(context).textTheme.bodyLarge,
        //         children: [
        //           TextSpan(
        //               text: tSignup,
        //               style: const TextStyle(color: Colors.blue)),
        //         ]),
        //   ),
        // ),
      ],
    );
  }
}
