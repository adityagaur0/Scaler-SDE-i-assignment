import 'package:dashboard/src/features/core/controllers/dashbord_controller.dart';
import 'package:dashboard/src/utils/constants/colour.dart';
import 'package:dashboard/src/utils/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

class Filter extends StatelessWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showPopover(
              context: context,
              bodyBuilder: (_) => Menu(),
              width: 230,
              height: 150,
              backgroundColor: secondaryColor,
              direction: PopoverDirection.bottom);
        },
        icon: const Icon(Icons.filter_list));
  }
}

class Menu extends StatelessWidget {
  Menu({super.key});
  // final propertycontroller = PropertyController.instance;
  final controller = DashboardController.instance;
  List<String> list = [
    "Assigned",
    "Unassigned",
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          GestureDetector(
              onTap: () {
                controller.selectedfilter.value = "All";
                // moneycontroller.selectedDate.value = "Current Month";
                Get.back();
              },
              child: Text("All")),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Container(
                  color: TColors.buttonPrimary
                      .withOpacity((index + 1) / list.length),
                  child: ListTile(
                    title: Text("${index + 1}. ${list[index]}"),
                    onTap: () {
                      controller.selectedfilter.value = list[index];
                      // moneycontroller.selectedDate.value = months[index];

                      Get.back();
                    },
                    trailing: Icon(Icons.arrow_right),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
