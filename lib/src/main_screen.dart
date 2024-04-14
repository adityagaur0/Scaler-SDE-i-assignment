import 'package:dashboard/src/features/core/controllers/dashbord_controller.dart';
import 'package:dashboard/src/features/core/controllers/user_controller/user_controller.dart';
import 'package:dashboard/src/features/core/screens/dashboard/dashboard_screen.dart';
import 'package:dashboard/src/utils/api/send_email.dart';
import 'package:dashboard/src/utils/device/responsive.dart';
import 'package:dashboard/src/common/widgets/side_menu.dart';
import 'package:dashboard/src/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(
      drawer: const SideMenu(),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {
            if (UserController.instance.user.value.marksSubmitted == false) {
              print("${controller.allStudent.length} " "ADDD");
              if (controller.allStudent.length < 4) {
                showModalBottomSheet(
                  isDismissible: true,
                  context: context,
                  builder: (context) => const AddStudentBottomSheet(),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('You can only add maximum 4 students'),
                  duration: Duration(seconds: 1),
                ));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Marks already submitted"),
                duration: Duration(seconds: 1),
              ));
            }
          },
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.add),
        ),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          heroTag: "btn2",
          onPressed: () {
            final anyUnassigned = controller.allStudent.any((student) =>
                student.idea == "Unassigned Marks" &&
                student.execution == "Unassigned Marks" &&
                student.viva == "Unassigned Marks");

            if (UserController.instance.user.value.marksSubmitted == false) {
              if (controller.allStudent.length > 2 && !anyUnassigned) {
                print(controller.allStudent.length);

                // Show confirmation dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Lock Marks Confirmation'),
                      content: const Text(
                          'Are you sure you want to lock the marks?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            controller.lockMarks();
                            // Lock the marks
                            // You can add your logic to lock the marks here
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                            // Do nothing, dismiss the dialog
                          },
                          child: const Text('No'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: controller.allStudent.length < 3
                      ? Text(
                          'You need to add ${3 - controller.allStudent.length} student')
                      : anyUnassigned
                          ? const Text(
                              "You need to assign marks to all students")
                          : const Text("error"),
                  duration: const Duration(seconds: 1),
                ));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Marks already submitted"),
                duration: Duration(seconds: 1),
              ));
            }
          },
          backgroundColor: Colors.blueAccent,
          child: Obx(
            () => UserController.instance.user.value.marksSubmitted
                ? const Icon(Icons.lock_outlined)
                : const Icon(Icons.lock_open),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          heroTag: "btn4",
          onPressed: () {
            if (UserController.instance.user.value.marksSubmitted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Upcoming feature"),
                duration: Duration(seconds: 1),
              ));
              // SendEmail().sendEmail(
              //     student_name: "aditya",
              //     enrollment_no: "001",
              //     student_email: "adityakumargaur0@gmail.com",
              //     total_marks: "10",
              //     viva: "3",
              //     idea: "2",
              //     execution: "5",
              //     mentor_name: "scalar",
              //     mentor_email: "adityakumargaur2020@gmail.com");
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please lock the marks first"),
                duration: Duration(seconds: 1),
              ));
            }
          },
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.email),
        ),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          heroTag: "btn3",
          onPressed: () {
            if (UserController.instance.user.value.marksSubmitted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Upcoming feature"),
                duration: Duration(seconds: 1),
              ));
              // SendEmail().sendEmail(
              //     student_name: "aditya",
              //     enrollment_no: "001",
              //     student_email: "adityakumargaur0@gmail.com",
              //     total_marks: "10",
              //     viva: "3",
              //     idea: "2",
              //     execution: "5",
              //     mentor_name: "scalar",
              //     mentor_email: "adityakumargaur2020@gmail.com");
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please lock the marks first"),
                duration: Duration(seconds: 1),
              ));
            }
          },
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.picture_as_pdf),
        ),
      ]),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            const Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

class AddStudentBottomSheet extends StatelessWidget {
  const AddStudentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
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
                "Add Student",
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
                validator: (value) =>
                    TValidator.validateEmptyText('Student Name', value),
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
                validator: (value) =>
                    TValidator.validateEmptyText('Student Email', value),
                expands: false,
                decoration: const InputDecoration(
                  hintText: 'Student Email*',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.erollmentNo,
                validator: (value) =>
                    TValidator.validateEmptyText('Enrollment Number', value),
                expands: false,
                decoration: const InputDecoration(
                  hintText: 'Enrollment Number*',
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
                  hintText: 'Ideation Marks /10',
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
                  hintText: 'Execution Marks /10',
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
                  hintText: 'Viva Marks /10',
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
                    bool hasDuplicate = controller.totalStudent.any((student) =>
                        student.ENo == controller.erollmentNo.text);
                    if (!hasDuplicate) {
                      // If no duplicate, show the bottom sheet to add the student
                      await controller
                          .addStudent(UserController.instance.user.value.id);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Enrollment Number already exists'),
                        duration: Duration(seconds: 1),
                      ));
                    }

                    print(
                        "${UserController.instance.user.value.assignedStudents.length}");
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
