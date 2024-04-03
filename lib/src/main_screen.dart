import 'package:dashboard/src/features/core/controllers/dashbord_controller.dart';
import 'package:dashboard/src/features/core/screens/dashboard/dashboard_screen.dart';
import 'package:dashboard/src/utils/constants/constants.dart';
import 'package:dashboard/src/utils/device/responsive.dart';
import 'package:dashboard/src/common/side_menu.dart';
import 'package:dashboard/src/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => AddStudentBottomSheet(),
            );
          },
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.add),
        ),
        SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.lock_open),
        ),
        SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.picture_as_pdf),
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
            Expanded(
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
  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: controller.studentFormkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Student \nMentor Name: ${controller.mentorname.text}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.studentName,
                validator: (value) =>
                    TValidator.validateEmptyText('Student Name', value),
                expands: false,
                decoration: const InputDecoration(
                  hintText: 'Student Name',
                ),
              ),
              TextFormField(
                controller: controller.studentEmail,
                validator: (value) =>
                    TValidator.validateEmptyText('Student Email', value),
                expands: false,
                decoration: const InputDecoration(
                  hintText: 'Student Email',
                ),
              ),
              TextFormField(
                controller: controller.ideaMarks,
                keyboardType: TextInputType.number,
                // validator: (value) =>
                //     TValidator.validateEmptyText('Student Name', value),
                expands: false,
                decoration: const InputDecoration(
                  hintText: 'Ideation Marks',
                ),
              ),
              TextFormField(
                controller: controller.executionMarks,
                keyboardType: TextInputType.number,
                // validator: (value) =>
                //     TValidator.validateEmptyText('Student Name', value),
                expands: false,
                decoration: const InputDecoration(
                  hintText: 'Execution Marks',
                ),
              ),
              TextFormField(
                controller: controller.vivaMarks,
                keyboardType: TextInputType.number,
                // validator: (value) =>
                //     TValidator.validateEmptyText('Student Name', value),
                expands: false,
                decoration: const InputDecoration(
                  hintText: 'Viva Marks',
                ),
              ),

              SizedBox(
                height: 20,
              ),
              // Add text form fields for other parameters such as execution, viva/pitch, etc.
              ElevatedButton(
                onPressed: () {
                  if (controller.studentFormkey.currentState!.validate() &&
                      controller.mentorid.isBlank!) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Not Valid'),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Mentor ID is blank. Go to top right corner and select the mentor'),
                      ),
                    );
                  }
                  // Handle form submission
                  // Submit student details to Firebase Firestore
                  // Calculate total marks and update in Firestore
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
