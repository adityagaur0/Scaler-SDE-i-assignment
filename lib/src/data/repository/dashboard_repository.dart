import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/src/features/core/models/mentor_model.dart';
import 'package:dashboard/src/features/core/models/student_model.dart';
import 'package:dashboard/src/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:dashboard/src/utils/exceptions/firebase_exceptions.dart';
import 'package:dashboard/src/utils/exceptions/format_exceptions.dart';
import 'package:dashboard/src/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DashboardRepository extends GetxController {
  static DashboardRepository get instance => Get.find();

  // Variables
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addMentorRecord(MentorModel mentor) async {
    try {
      // Generate a new property ID if it's not provided
      if (mentor.MentorId.isEmpty) {
        mentor.MentorId = _db.collection("Mentor").doc().id;
      }

      await _db.collection("Mentor").doc(mentor.MentorId).set(mentor.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<MentorModel>> getAllMentors() async {
    try {
      // it will return the all the property detials where owner id = auth user id.

      final snapshot = await _db.collection('Mentor').get();

      final list = snapshot.docs
          .map((document) => MentorModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<StudentModel>> getAllStudent(String mentorID) async {
    try {
      // it will return the all the property detials where owner id = auth user id.
      final snapshot = await _db
          .collection('Student')
          .where('MentorId', isEqualTo: mentorID)
          .get();

      final list = snapshot.docs
          .map((document) => StudentModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<StudentModel>> getTotalStudent() async {
    try {
      // it will return the all the property detials where owner id = auth user id.
      final snapshot = await _db.collection('Student').get();

      final list = snapshot.docs
          .map((document) => StudentModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> addStudentRecord(StudentModel student) async {
    try {
      // Generate a new property ID if it's not provided

      await _db
          .collection("Student")
          .doc(student.StudentId)
          .set(student.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> deleteStudentRecord(String StudentId) async {
    try {
      await _db.collection("Student").doc(StudentId).delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateSingleStudentField(
      String studentId, Map<String, dynamic> json) async {
    try {
      await _db.collection("Student").doc(studentId).update(json);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateSingleUserField(
      String MentorId, Map<String, dynamic> json) async {
    try {
      await _db.collection("Users").doc(MentorId).update(json);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Future<bool> checkMaintenanceMode() async {
  //   try {
  //     final snapshot = await _db.collection('MaintenanceMode').get();

  //     if (snapshot.docs.isNotEmpty) {
  //       final status = snapshot.docs.first.get('Status');
  //       return status ?? false;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }

  // Future<void> updateMaintenanceMode(bool newValue) async {
  //   try {
  //     await _db
  //         .collection('MaintenanceMode')
  //         .doc('Ht4Ass6gtT5UMDDFFaOX')
  //         .set({'Status': newValue});
  //   } catch (e) {
  //     throw 'Failed to update maintenance mode. Please try again';
  //   }
  // }

  // Future<List<TenantModel>> getAllTesterTenant(String ownerId) async {
  //   try {
  //     // it will return the all the property detials where owner id = auth user id.

  //     final snapshot = await _db
  //         .collection('Tenants')
  //         .where('OwnerId', isEqualTo: ownerId)
  //         // .where('OwnerId', isEqualTo: "4ICzptrMxjMxUGUzCaTyka1kzEF2")
  //         .where('Status', isEqualTo: "Occupied")
  //         .get();

  //     final list = snapshot.docs
  //         .map((document) => TenantModel.fromSnapshot(document))
  //         .toList();

  //     return list;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }

  // // Future<List<TenantModel>> getAllProductionTenant(String ownerId) async {
  // //   try {
  // //     // it will return the all the property detials where owner id = auth user id.

  // //     final snapshot = await _db
  // //         .collection('Tenants')
  // //         .where('OwnerId', isNotEqualTo: ownerId)
  // //         // .where('OwnerId', isEqualTo: "4ICzptrMxjMxUGUzCaTyka1kzEF2")
  // //         .where('Status', isEqualTo: "Occupied")
  // //         .get();

  // //     final list = snapshot.docs
  // //         .map((document) => TenantModel.fromSnapshot(document))
  // //         .toList();

  // //     return list;
  // //   } catch (e) {
  // //     throw 'Something went wrong. Please try again';
  // //   }
  // // }
  // Future<List<TenantModel>> getAllProductionTenant() async {
  //   try {
  //     // print('OwnerId: $ownerId'); // Print ownerId for debugging

  //     // Fetch tenants where OwnerId is not equal to the specified ownerId
  //     final snapshot = await _db
  //         .collection('Tenants')

  //         .where('Status', isEqualTo: "Occupied")
  //         .get();

  //     print(
  //         'Number of documents retrieved: ${snapshot.docs.length}'); // Print number of documents retrieved

  //     // Map documents to TenantModel objects
  //     final list = snapshot.docs
  //         .map((document) => TenantModel.fromSnapshot(document))
  //         .toList();

  //     return list;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }

  // Future<void> updateSingleTenantField(
  //     String TenantId, Map<String, dynamic> json) async {
  //   try {
  //     await _db.collection("Tenants").doc(TenantId).update(json);
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }

  // Future<void> addDueRecord(DueModel due) async {
  //   try {
  //     // Generate a new property ID if it's not provided
  //     if (due.DueId.isEmpty) {
  //       due.DueId = _db.collection("Dues").doc().id;
  //     }
  //     await _db.collection("Dues").doc(due.DueId).set(due.toJson());
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }
}
