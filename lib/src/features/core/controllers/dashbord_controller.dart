import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/src/features/core/controllers/user_controller/user_controller.dart';
import 'package:dashboard/src/features/core/models/mentor_model.dart';
import 'package:dashboard/src/features/core/models/student_model.dart';
import 'package:dashboard/src/utils/constants/imges_string.dart';
import 'package:dashboard/src/utils/helpers/network_manager.dart';
import 'package:dashboard/src/utils/popups/full_screen_loader.dart';
import 'package:dashboard/src/utils/popups/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/dashboard_repository.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final DashboardRepository repository = Get.put(DashboardRepository());

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchStudentDetials();
    fetchALLStudentDetials();
    // // Fetch initial maintenance mode status from Firestore
  }

  final isLoading = false.obs;
  RxList<MentorModel> allMentor = <MentorModel>[].obs;
  RxList<StudentModel> allStudent = <StudentModel>[].obs;
  RxList<StudentModel> totalStudent = <StudentModel>[].obs;
  final mentorname = TextEditingController();
  final mentorid = TextEditingController();
  GlobalKey<FormState> studentFormkey = GlobalKey<FormState>();
  final studentName = TextEditingController();
  final erollmentNo = TextEditingController();
  final studentEmail = TextEditingController();
  final ideaMarks = TextEditingController();
  final executionMarks = TextEditingController();
  final vivaMarks = TextEditingController();
  MentorModel mentor = MentorModel.empty();

  RxString selectedfilter = "All".obs;

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
  Future<void> fetchStudentDetials() async {
    print(_auth.currentUser!.uid);
    try {
      // show loader
      isLoading.value = true;

      // Clear the existing list of properties
      allStudent.clear(); // Clear the list before adding new data

      // Fetch property from data source( eg. FireStore, api , sql etc)
      final student = await repository.getAllStudent(_auth.currentUser!.uid);

      // Update the Categories List
      allStudent.assignAll(student);
      fetchALLStudentDetials();
      print(allStudent.length);

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

  Future<void> fetchALLStudentDetials() async {
    print(_auth.currentUser!.uid);
    try {
      // show loader
      isLoading.value = true;

      // Clear the existing list of properties
      totalStudent.clear(); // Clear the list before adding new data

      // Fetch property from data source( eg. FireStore, api , sql etc)
      final student = await repository.getTotalStudent();

      // Update the Categories List
      totalStudent.assignAll(student);
      // print(allStudent.length);

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
      String StudentId = _db.collection("Student").doc().id;

      final student = StudentModel(
        StudentId: StudentId,
        MentorId: mentorId.trim(),
        StudentName: studentName.text.trim(),
        emailId: studentEmail.text.trim(),
        ENo: erollmentNo.text.trim(),
        marks:
            (int.parse(ideaMarks.text.isEmpty ? "0" : ideaMarks.text.trim()) +
                    int.parse(
                        vivaMarks.text.isEmpty ? "0" : vivaMarks.text.trim()) +
                    int.parse(executionMarks.text.isEmpty
                        ? "0"
                        : executionMarks.text.trim()))
                .toString(),
        idea:
            ideaMarks.text.isEmpty ? "Unassigned Marks" : ideaMarks.text.trim(),
        viva:
            vivaMarks.text.isEmpty ? "Unassigned Marks" : vivaMarks.text.trim(),
        execution: executionMarks.text.isEmpty
            ? "Unassigned Marks"
            : executionMarks.text.trim(),
      );
      print("forth");
      // print("${_auth.currentUser!.displayName}a");
      // ADD property to firebase
      Map<String, dynamic> update() {
        // Add the student to the assignedStudents list
        List<String> updatedAssignedStudents =
            List.from(UserController.instance.user.value.assignedStudents);
        updatedAssignedStudents.add(StudentId);

        // Create the JSON map for updating the user data
        return {
          "assignedStudents": updatedAssignedStudents,
        };
      }

      await repository.addStudentRecord(student);
      await repository.updateSingleUserField(mentorId, update());
      fetchStudentDetials();

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

  Future<void> deleteStudent(String studentId, String mentorId) async {
    try {
      // print("first");
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'We are Deleting Student information...', TImages.docerAnimation);
      // print("2");

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      Map<String, dynamic> delete() {
        // Remove the student from the assignedStudents list
        List<String> updatedAssignedStudents =
            List.from(UserController.instance.user.value.assignedStudents);
        updatedAssignedStudents.remove(studentId);

        // Create the JSON map for updating the user data
        return {
          "assignedStudents": updatedAssignedStudents,
        };
      }

      await repository.deleteStudentRecord(studentId);

      await repository.updateSingleUserField(mentorId, delete());

      await fetchStudentDetials();
      //

      //5. stop loading
      TFullScreenLoader.stopLoading();

      //6. show success message
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Student has been Deleted');

      //7. move to previous screen
      // Get.off(() => ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e);
    }
  }

  Future<void> lockMarks() async {
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

      Map<String, dynamic> update() {
        return {
          "marksSubmitted": true,
        };
      }

      await repository.updateSingleUserField(_auth.currentUser!.uid, update());
      fetchStudentDetials();
      UserController.instance.fetchUserRecord();

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
          title: 'Congratulations', message: 'Marks are locked');

      //7. move to previous screen
      // Get.off(() => ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e);
    }
  }
}
