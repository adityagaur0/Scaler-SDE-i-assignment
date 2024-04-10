// Assuming you're using Firestore

import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  StudentModel({
    required this.StudentId,
    required this.StudentName,
    required this.emailId,
    required this.MentorId,
    required this.ENo,
    required this.marks,
    required this.execution,
    required this.idea,
    required this.viva,
  });

  String StudentId;
  String StudentName;
  String emailId;
  String MentorId; // Assuming MentorId is a list of student IDs
  String ENo;
  String marks;
  String idea;
  String viva;
  String execution;

  // Helper function to create an empty mentor model
  static StudentModel empty() => StudentModel(
        StudentId: '',
        StudentName: '',
        emailId: '',
        MentorId: '',
        ENo: '',
        marks: '',
        idea: '',
        execution: '',
        viva: '',
      );

  // Convert the model to JSON structure to store the data in Firebase

  Map<String, dynamic> toJson() {
    return {
      "StudentId": StudentId,
      "StudentName": StudentName,
      "emailId": emailId,
      "MentorId": MentorId,
      "ENo": ENo,
      "marks": marks,
      "idea": idea,
      "viva": viva,
      "execution": execution,
    };
  }

  // Factory method to create a mentor from Firebase document snapshot
  factory StudentModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return StudentModel(
        StudentId: data['StudentId'] ?? '',
        StudentName: data['StudentName'] ?? '',
        emailId: data['emailId'] ?? '',
        MentorId: data['MentorId'] ?? '',
        ENo: data['ENo'] ?? '',
        marks: data['marks'] ?? '',
        viva: data['viva'] ?? '',
        idea: data['idea'] ?? '',
        execution: data['execution'] ?? '',
      );
    } else {
      return StudentModel.empty();
    }
  }
}
