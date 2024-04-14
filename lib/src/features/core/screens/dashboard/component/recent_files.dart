import 'package:dashboard/src/features/core/controllers/dashbord_controller.dart';
import 'package:dashboard/src/features/core/controllers/update_student_controller.dart';
import 'package:dashboard/src/features/core/controllers/user_controller/user_controller.dart';
import 'package:dashboard/src/features/core/models/student_model.dart';
import 'package:dashboard/src/features/core/screens/dashboard/widget/filter.dart';
import 'package:dashboard/src/utils/constants/constants.dart';
import 'package:dashboard/src/utils/device/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Students",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                width: 20,
              ),
              const Spacer(),
              const Filter(),
            ],
          ),
          Obx(
            () => Text(
              "*Minimum 3 and Maximum 4 students allowed. [${controller.allStudent.length}/4]",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: defaultPadding),
          const Expanded(child: PeopleListWidget()),
        ],
      ),
    );
  }
}

class PeopleListWidget extends StatelessWidget {
  const PeopleListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;

    return Obx(() {
      // final anyUnassigned = controller.allStudent.any((student) =>
      //     student.idea == "Unassigned Marks" &&
      //     student.execution == "Unassigned Marks" &&
      //     student.viva == "Unassigned Marks");

      final filteredList = controller.allStudent.where((student) {
        if (controller.selectedfilter.value == "Assigned") {
          return student.idea != "Unassigned Marks" &&
              student.execution != "Unassigned Marks" &&
              student.viva != "Unassigned Marks";
        } else if (controller.selectedfilter.value == "Unassigned") {
          return student.idea == "Unassigned Marks" &&
              student.execution == "Unassigned Marks" &&
              student.viva == "Unassigned Marks";
        } else {
          // Show both assigned and unassigned students
          return true;
        }
      }).toList();

      return filteredList.isEmpty
          ? const Center(
              child: Text("No Students. Add students to view here."),
            )
          // ? NoDetialsAnimationText(
          //     t1: 'Collection',
          //     lottie: TImages.monkey,
          //   )
          : ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (_, index) {
                final student = filteredList[index];
                final updatecontroller = Get.put(UpdateStudentController(
                    student: Rx<StudentModel>(student)));

                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Student Name ",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                Text("Email",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                Text("Enrollment Number",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                Text("Total Marks",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                Text("Idea Marks",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                Text("Viva Marks",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                Text("Execution Marks",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(": ${student.StudentName}",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text(": ${student.emailId}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text(": ${student.ENo}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text(": ${student.marks} / 30",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text(": ${student.idea} / 10",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text(": ${student.viva} / 10",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text(": ${student.execution} / 10",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium)
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: Responsive.isMobile(context) ? 60 : 150,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (UserController
                                        .instance.user.value.marksSubmitted ==
                                    false) {
                                  updatecontroller.studentName.text =
                                      student.StudentName;
                                  updatecontroller.studentEmail.text =
                                      student.emailId;
                                  updatecontroller.vivaMarks.text =
                                      student.viva;
                                  updatecontroller.ideaMarks.text =
                                      student.idea;
                                  updatecontroller.executionMarks.text =
                                      student.execution;

                                  // updatecontroller.initializeDetails(student);
                                  await showModalBottomSheet(
                                    isDismissible: true,
                                    context: context,
                                    builder: (context) => EditStudentSheet(
                                      student: student,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Marks already submitted"),
                                    duration: Duration(seconds: 1),
                                  ));
                                }
                              },
                              child: const Text("Edit",
                                  style: TextStyle(fontSize: 12)),
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: Responsive.isMobile(context) ? 60 : 150,
                            child: ElevatedButton(
                              onPressed: () {
                                if (UserController
                                        .instance.user.value.marksSubmitted ==
                                    false) {
                                  controller.deleteStudent(
                                      student.StudentId.trim(),
                                      student.MentorId.trim());
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Marks already submitted"),
                                    duration: Duration(seconds: 1),
                                  ));
                                }
                              },
                              child: const Text("Remove",
                                  style: TextStyle(fontSize: 12)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
    });
  }
}

class EditStudentSheet extends StatelessWidget {
  EditStudentSheet({super.key, required this.student});
  StudentModel student;

  @override
  Widget build(BuildContext context) {
    final controller = UpdateStudentController.instance;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.studentFormkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Student",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              // Text(
              //   "${UserController.instance.user.value.firstName}",
              //   style: Theme.of(context).textTheme.titleMedium,
              // ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.studentName,
                expands: false,
                decoration: const InputDecoration(
                  hintText: 'Student Name*',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.studentEmail,
                expands: false,
                decoration: const InputDecoration(
                  hintText: 'Student Email*',
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              TextFormField(
                controller: controller.ideaMarks,
                keyboardType: TextInputType.number,
                // Uncomment this line and set the initial value to '0'
                // validator: (value) =>
                //     TValidator.validateEmptyText('Student Name', value),
                expands: false,
                decoration: const InputDecoration(
                  hintText: 'Ideation Marks/10',
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.executionMarks,
                keyboardType: TextInputType.number,
                // initialValue: '0',
                // validator: (value) =>
                //     TValidator.validateEmptyText('Student Name', value),
                expands: false,
                decoration: const InputDecoration(
                  hintText: 'Execution Marks/10',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.vivaMarks,
                // initialValue: '0',
                keyboardType: TextInputType.number,
                // validator: (value) =>
                //     TValidator.validateEmptyText('Student Name', value),
                expands: false,
                decoration: const InputDecoration(
                  hintText: 'Viva Marks/10',
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              // Add text form fields for other parameters such as execution, viva/pitch, etc.
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await controller.updateStudent(student);
                    // } else {
                    //   await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content: Text(
                    //         'You can only maximum 4 students and minimum 3 students'),
                    //     duration: Duration(seconds: 1),
                    //   ));
                    // }

                    // if (controller.studentFormkey.currentState!.validate() &&
                    //     controller.mentorid.isBlank!) {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content: Text('Not Valid'),
                    //   ));
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text(
                    //           'Mentor ID is blank. Go to top right corner and select the mentor'),
                    //     ),
                    //   );
                    // }
                    // Handle form submission
                    // Submit student details to Firebase Firestore
                    // Calculate total marks and update in Firestore
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
