// Assuming you're using Firestore

import 'package:cloud_firestore/cloud_firestore.dart';


class MentorModel {
  MentorModel({
    required this.MentorId,
    required this.MentorName,
    required this.emailId,
    required this.assignedStudents,
    required this.marksSubmitted,
  });
  
  String MentorId;
  String MentorName;
  String emailId;
  List<String>
      assignedStudents; // Assuming assignedStudents is a list of student IDs
  bool marksSubmitted;

  // Helper function to create an empty mentor model
  static MentorModel empty() => MentorModel(
        MentorId: '',
        MentorName: '',
        emailId: '',
        assignedStudents: [],
        marksSubmitted: false,
      );

  // Convert the model to JSON structure to store the data in Firebase

  Map<String, dynamic> toJson() {
    return {
      "MentorId": MentorId,
      "MentorName": MentorName,
      "emailId": emailId,
      "assignedStudents": assignedStudents,
      "marksSubmitted": marksSubmitted,
    };
  }

  // Factory method to create a mentor from Firebase document snapshot
  factory MentorModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return MentorModel(
        MentorId: data['MentorId'] ?? '',
        MentorName: data['MentorName'] ?? '',
        emailId: data['emailId'] ?? '',
        assignedStudents: List<String>.from(data['assignedStudents'] ?? []),
        marksSubmitted: data['marksSubmitted'] ?? false,
      );
    } else {
      return MentorModel.empty();
    }
  }
}
