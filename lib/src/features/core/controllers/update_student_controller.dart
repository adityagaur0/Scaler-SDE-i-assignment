import 'package:dashboard/src/features/core/controllers/dashbord_controller.dart';
import 'package:dashboard/src/features/core/models/student_model.dart';
import 'package:dashboard/src/utils/constants/imges_string.dart';
import 'package:dashboard/src/utils/helpers/network_manager.dart';
import 'package:dashboard/src/utils/popups/full_screen_loader.dart';
import 'package:dashboard/src/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/dashboard_repository.dart';

class UpdateStudentController extends GetxController {
  static UpdateStudentController get instance => Get.find();

  final DashboardRepository repository = Get.put(DashboardRepository());

  final isLoading = false.obs;
  Rx<StudentModel> student = StudentModel.empty().obs;

  GlobalKey<FormState> studentFormkey = GlobalKey<FormState>();
  final studentName = TextEditingController();

  final studentEmail = TextEditingController();
  final ideaMarks = TextEditingController();
  final executionMarks = TextEditingController();
  final vivaMarks = TextEditingController();

  UpdateStudentController({required this.student}) {
    initializeDetails(); // Initialize details with the selected property
  }

  Future<void> initializeDetails() async {
    studentName.text = student.value.StudentName;
    studentEmail.text = student.value.emailId;
    ideaMarks.text = student.value.idea;
    executionMarks.text = student.value.execution;
    vivaMarks.text = student.value.viva;
    // Reset text editing controllers to empty strings
  }

  Future<void> updateStudent(StudentModel Student) async {
    try {
      print("fir st");
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'We are Adding Student information...', TImages.docerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      print("second");
      // 3. Form Validation
      if (!studentFormkey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //4.
      print("third");

      // final student = StudentModel(
      //   StudentId: Student.StudentId,
      //   MentorId: Studen,
      //   StudentName: studentName.text.trim(),
      //   emailId: studentEmail.text.trim(),
      //   ENo: erollmentNo.text.trim(),
      // marks:
      //     (int.parse(ideaMarks.text.isEmpty ? "0" : ideaMarks.text.trim()) +
      //             int.parse(
      //                 vivaMarks.text.isEmpty ? "0" : vivaMarks.text.trim()) +
      //             int.parse(executionMarks.text.isEmpty
      //                 ? "0"
      //                 : executionMarks.text.trim()))
      //         .toString(),
      //   idea: ideaMarks.text.isEmpty ? "0" : ideaMarks.text.trim(),
      //   viva: vivaMarks.text.isEmpty ? "0" : vivaMarks.text.trim(),
      //   execution:
      //       executionMarks.text.isEmpty ? "0" : executionMarks.text.trim(),
      // );

      // print("${_auth.currentUser!.displayName}a");
      // ADD property to firebase
      Map<String, dynamic> update() {
        return {
          "StudentName": studentName.text.trim(),
          "emailId": studentEmail.text.trim(),
          "marks": (int.parse(ideaMarks.text.trim()) +
                  int.parse(vivaMarks.text.trim()) +
                  int.parse(executionMarks.text.trim()))
              .toString(),
          "idea": ideaMarks.text.trim(),
          "viva": vivaMarks.text.trim(),
          "execution": executionMarks.text.trim()
        };
      }

      await repository.updateSingleStudentField(Student.StudentId, update());
      await DashboardController.instance.fetchStudentDetials();

      student.value.StudentName = studentName.text.trim();
      student.value.emailId = studentEmail.text.trim();
      student.value.idea = ideaMarks.text.trim();
      student.value.execution = executionMarks.text.trim();
      student.value.viva = vivaMarks.text.trim();

      // 5. stop loading
      TFullScreenLoader.stopLoading();

      //7. get .back
      Get.back();

      //6. show success message
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Student has been added');

      //7. move to previous screen
      // Get.off(() => ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e);
    }
  }
}
