import 'package:cloud_firestore/cloud_firestore.dart';

class EvaluationModel {
  EvaluationModel({
    required this.evaluationId,
    required this.mentorId,
    required this.studentId,
    required this.ideationMarks,
    required this.executionMarks,
    required this.vivaMarks,
  });

  String evaluationId;
  String mentorId;
  String studentId;
  int ideationMarks;
  int executionMarks;
  int vivaMarks;

  // Helper function to create an empty evaluation model
  static EvaluationModel empty() => EvaluationModel(
        evaluationId: '',
        mentorId: '',
        studentId: '',
        ideationMarks: 0,
        executionMarks: 0,
        vivaMarks: 0,
      );

  // Convert the model to JSON structure to store the data in Firebase
  Map<String, dynamic> toJson() {
    return {
      "evaluationId": evaluationId,
      "mentorId": mentorId,
      "studentId": studentId,
      "ideationMarks": ideationMarks,
      "executionMarks": executionMarks,
      "vivaMarks": vivaMarks,
    };
  }

  // Factory method to create an evaluation from Firebase document snapshot
  factory EvaluationModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return EvaluationModel(
        evaluationId: data['evaluationId'] ?? '',
        mentorId: data['mentorId'] ?? '',
        studentId: data['studentId'] ?? '',
        ideationMarks: data['ideationMarks'] ?? 0,
        executionMarks: data['executionMarks'] ?? 0,
        vivaMarks: data['vivaMarks'] ?? 0,
      );
    } else {
      return EvaluationModel.empty();
    }
  }
}
