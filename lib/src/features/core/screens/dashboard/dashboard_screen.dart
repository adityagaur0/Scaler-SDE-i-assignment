import 'package:dashboard/src/features/core/controllers/dashbord_controller.dart';
import 'package:dashboard/src/features/core/controllers/user_controller/user_controller.dart';
import 'package:dashboard/src/features/core/screens/dashboard/component/header.dart';
import 'package:dashboard/src/features/core/screens/dashboard/component/recent_files.dart';
import 'package:dashboard/src/utils/device/responsive.dart';
import 'package:dashboard/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final dashboed = Get.put(DashboardController());
    print(controller.user.value);
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      // const MyFiles(),
                      const SizedBox(height: defaultPadding),
                      const StudentInfo(),
                      if (Responsive.isMobile(context))
                        const SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) const SizedBox(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
