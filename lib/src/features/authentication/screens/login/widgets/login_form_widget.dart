import 'package:dashboard/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(LoginController());
    return Form(
      // key: controller.loginformKey,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            ///
            ///  Email
            TextFormField(
              //   validator: (value) => TValidator.validateEmail(value),
              //  controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            ///
            /// Password
            TextFormField(
              // controller: controller.password,
              // validator: (value) => TValidator.validatePassword(value),
              expands: false,
              // obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: "Password",
                suffixIcon: IconButton(
                  onPressed: () {}, // toggling the value again and again
                  icon: const Icon(Icons.remove_red_eye),
                ),
              ),
            ),

            const SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),

            ///
            ///
            /// Forget password and remember me
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                        value: false,
                        onChanged: (value) {
                          // controller.rememberMe.value =
                          //     !controller.rememberMe.value;
                        }),
                    const Text("Remember Me"),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // ForgetPasswordScreen.buildShowBottomModalSheet(context);
                  },
                  child: const Text("Forget Password"),
                ),
              ],
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Sign In"),
                )),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("Create Account"),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
          ],
        ),
      ),
    );
  }
}
