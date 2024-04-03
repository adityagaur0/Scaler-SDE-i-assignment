import 'package:dashboard/src/features/core/controllers/dashbord_controller.dart';
import 'package:dashboard/src/utils/device/responsive.dart';
import 'package:dashboard/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        const Expanded(child: SearchField()),
        ProfileCard(),
        // Expanded(
        //   child: TextFormField(
        //     readOnly: true, // Make the field read-only
        //     onTap: () {
        //       controller.mentorname.clear();

        //       Get.bottomSheet(
        //         Obx(
        //           () => Container(
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.only(
        //                     topLeft: Radius.circular(20),
        //                     topRight: Radius.circular(20)),
        //                 color: Colors.white,
        //               ),
        //               height: 250,
        //               child: controller.allMentor.isEmpty
        //                   ? Center(
        //                       child: Padding(
        //                         padding:
        //                             const EdgeInsets.symmetric(horizontal: 20),
        //                         child: Column(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: [
        //                             Text(
        //                               "No mentor added.",
        //                               style: Theme.of(context)
        //                                   .textTheme
        //                                   .titleLarge,
        //                             ),
        //                             SizedBox(
        //                               height: 20,
        //                             ),
        //                             SizedBox(
        //                               width: double.infinity,
        //                               child: ElevatedButton(
        //                                 onPressed: () {
        //                                   // Get.to(() => AddPropertyPro());
        //                                 },
        //                                 child: Text(
        //                                   "Please add mentor",
        //                                   style: TextStyle(color: Colors.black),
        //                                 ),
        //                                 // style: ElevatedButton.styleFrom(
        //                                 //   backgroundColor:
        //                                 //       tEditProfileButtonColor,
        //                                 //   side: BorderSide.none,
        //                                 //   shape: const StadiumBorder(),
        //                                 // ),
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                     )
        //                   : ListView.builder(
        //                       itemCount: controller.allMentor.length,
        //                       itemBuilder: (context, index) {
        //                         final mentor = controller.allMentor[index];
        //                         return Container(
        //                           margin: EdgeInsets.symmetric(
        //                               vertical: 5.0, horizontal: 10.0),
        //                           decoration: BoxDecoration(
        //                             border: Border.all(
        //                                 color: Colors.black, width: 1.0),
        //                             borderRadius: BorderRadius.circular(10.0),
        //                           ),
        //                           child: ListTile(
        //                             title: Text(
        //                               "${index + 1}. ${mentor.MentorName}",
        //                             ),
        //                             onTap: () {
        //                               controller.mentorname.text =
        //                                   mentor.MentorName;
        //                               controller.mentorid.text =
        //                                   mentor.MentorId;
        //                               // propertyLayoutController
        //                               //     .fetchPropertyLayoutDetials(
        //                               //         property.PropertyId);
        //                               Get.back();
        //                             },
        //                           ),
        //                         );
        //                       },
        //                     )),
        //         ),
        //       );
        //     },
        //     controller: controller.mentorname..text = "Select Mentor",
        //     // validator: (value) =>
        //     //     TValidator.validateEmptyText('Property Name', value),

        //     decoration: const InputDecoration(
        //       contentPadding:
        //           EdgeInsets.symmetric(vertical: 12.0, horizontal: .0),
        //       isCollapsed: true,
        //       hintText: 'Property Name',
        //       // prefixIcon: Icon(
        //       //   LineAwesomeIcons.building_1,
        //       // ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
// class Header extends StatelessWidget {
//   const Header({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             // Add any other widgets you want to place at the start here
//             // Example: Icon(Icons.menu),
//           ],
//         ),
//         Expanded(child: SearchField()),
//         Spacer(),
//         ProfileCard(),
//       ],
//     );
//   }
// }

class ProfileCard extends StatelessWidget {
  ProfileCard({
    Key? key,
  }) : super(key: key);
  final controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showProfileMenu(context);
        controller.fetchMentorDetials();
      },
      child: Container(
        margin: const EdgeInsets.only(left: defaultPadding),
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Icon(Icons.person),
            if (!Responsive.isMobile(context))
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Text("Mentor: ${controller.mentorname.text}"),
              ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Obx(
          () => Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.allMentor.length,
                      itemBuilder: (context, index) {
                        final mentor = controller.allMentor[index];
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text(
                              "${index + 1}. ${mentor.MentorName}",
                            ),
                            onTap: () {
                              controller.mentorname.text = mentor.MentorName;
                              controller.mentorid.text = mentor.MentorId;
                              controller.mentor = mentor;

                              print(mentor.MentorId);

                              // propertyLayoutController
                              //     .fetchPropertyLayoutDetials(
                              //         property.PropertyId);
                              Get.back();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add),
                    title: Text('New Mentor'),
                    onTap: () {
                      controller.addMentor();
                      // Handle creating new profile
                      // Close the modal
                    },
                  ),
                ],
              )),
        );
      },
    );
    // showModalBottomSheet(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return Container(
    //       color: secondaryColor,
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: <Widget>[
    //           ListTile(
    //             leading: Icon(Icons.person),
    //             title: Text('Mentor 1'),
    //             onTap: () {
    //               // Handle switching profile
    //               Navigator.pop(context); // Close the modal
    //             },
    //           ),
    //           ListTile(
    //             leading: Icon(Icons.person_add),
    //             title: Text('New Mentor'),
    //             onTap: () {
    //               controller.addMentor();
    //               // Handle creating new profile
    //               // Close the modal
    //             },
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
          hintText: "Student Id or Name",
          //fillColor: secondaryColor,
          // filled: true,
          border: OutlineInputBorder(
            // borderSide: BorderSide,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          prefixIcon: Icon(Icons.search)
          // suffixIcon: InkWell(
          //   onTap: () {},
          //   child: Container(
          //     padding: const EdgeInsets.all(defaultPadding * 0.75),
          //     margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
          //     decoration: const BoxDecoration(
          //       color: primaryColor,
          //       borderRadius: BorderRadius.all(Radius.circular(10)),
          //     ),
          //     child: SvgPicture.asset("assets/icons/Search.svg"),
          //   ),
          // ),
          ),
    );
  }
}
