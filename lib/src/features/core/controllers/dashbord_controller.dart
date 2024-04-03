import 'package:dashboard/src/features/core/models/mentor_model.dart';
import 'package:dashboard/src/features/core/models/student_model.dart';
import 'package:dashboard/src/utils/constants/imges_string.dart';
import 'package:dashboard/src/utils/helpers/network_manager.dart';
import 'package:dashboard/src/utils/popups/full_screen_loader.dart';
import 'package:dashboard/src/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/dashboard_repository.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final DashboardRepository repository = Get.put(DashboardRepository());

  // RxBool maintenanceMode = false.obs;
  // RxList<TenantModel> allTesterTenants = <TenantModel>[].obs;
  // RxList<TenantModel> allProductionTenants = <TenantModel>[].obs;
  // final isLoading = false.obs;

  // TextEditingController pinController = TextEditingController();
  // final pinFocusNode = FocusNode();

  // String enteredPin = '';
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchMentorDetials();
    // // Fetch initial maintenance mode status from Firestore
  }

  final isLoading = false.obs;
  RxList<MentorModel> allMentor = <MentorModel>[].obs;
  final mentorname = TextEditingController();
  final mentorid = TextEditingController();
  GlobalKey<FormState> studentFormkey = GlobalKey<FormState>();
  final studentName = TextEditingController();
  final studentEmail = TextEditingController();
  final ideaMarks = TextEditingController();
  final executionMarks = TextEditingController();
  final vivaMarks = TextEditingController();
  MentorModel mentor = MentorModel.empty();

  //------------------------Mentor-----------------------//
  Future<void> fetchMentorDetials() async {
    try {
      // show loader
      isLoading.value = true;

      // Clear the existing list of properties
      allMentor.clear(); // Clear the list before adding new data

      // Fetch property from data source( eg. FireStore, api , sql etc)
      final mentor = await repository.getAllMentors();

      // Update the Categories List
      allMentor.assignAll(mentor);
      print(allMentor.length);

      //Filter Feature Categories
      // ! To get filtered categories.
      // filterProperties.assignAll(allProperties.where((property) => property.City=="Delhi" && property.anyting we want).take(8).toList());

      //
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
      // remove the loader
    }
  }

  Future<void> addMentor() async {
    try {
      print("first");
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'We are Adding Due information...', TImages.docerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      print("second");
      // 3. Form Validation
      // if (!formkey.currentState!.validate()) {
      //   TFullScreenLoader.stopLoading();
      //   return;
      // }

      //4.
      print("third");
      final mentor = MentorModel(
        MentorId: '',
        MentorName: "Mentor 1",
        emailId: "mentor1@gmail.com",
        assignedStudents: ["01", "02", "03", "04"],
        marksSubmitted: false,
      );
      print("forth");
      // ADD property to firebase
      await repository.addMentorRecord(mentor);

      //add property manually
      // update();
      // fetchDues(TenantId);
      // fetchTotalDues(TenantId);

      // dueType.text = '';
      // dueAmount.text = '';
      // description.text = '';
      // dueStartDate.text = '';

      // 5. stop loading
      TFullScreenLoader.stopLoading();

      //7. get .back
      Get.back();

      //6. show success message
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Mentor has been added');

      //7. move to previous screen
      // Get.off(() => ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e);
    }
  }

//------------------------STUDENT-----------------------//
  Future<void> addStudent(String mentorId) async {
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
      final student = StudentModel(
        StudentId: '',
        MentorId: mentorId.trim(),
        StudentName: studentName.text.trim(),
        emailId: studentEmail.text.trim(),
        marks: (int.parse(ideaMarks.text) +
                int.parse(vivaMarks.text) +
                int.parse(executionMarks.text))
            .toString(),
        idea: ideaMarks.text.trim(),
        viva: vivaMarks.text.trim(),
        execution: executionMarks.text.trim(),
      );
      print("forth");
      // ADD property to firebase

      await repository.addStudentRecord(student);
      fetchMentorDetials();

      //add property manually
      // update();
      // fetchDues(TenantId);
      // fetchTotalDues(TenantId);

      // dueType.text = '';
      // dueAmount.text = '';
      // description.text = '';
      // dueStartDate.text = '';

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
