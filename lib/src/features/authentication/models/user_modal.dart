// 1 create model

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/src/utils/formatters/formatter.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNo,
    required this.profilePicture,
    required this.assignedStudents,
    required this.marksSubmitted,
  });
  final String id;
  String firstName;
  String lastName;
  String username;
  String email;
  String phoneNo;
  List<String> assignedStudents;
  bool marksSubmitted;

  String profilePicture;

  // ----------------- HELPER FN---------------- //(not imp)

  /// Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format phone number.
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNo);

  /// Static function to split full name into first and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String camelCaseUsername =
        "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "$camelCaseUsername"; //  prefix
    return usernameWithPrefix;
  }

  //static fn to create empty user modal
  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        phoneNo: '',
        profilePicture: '',
        marksSubmitted: false,
        assignedStudents: [],
      );

  // ------------------- HELPER FNN END -------------- //
//
  /// convert the modal to json structure to store the data in firebase.
  Map<String, dynamic> toJson() {
    return {
      "Firstname": firstName,
      "Lastname": lastName,
      "Username": username, // Use the actual username property here
      "Email": email,
      "Phone": phoneNo,
      "Profile picture": profilePicture, // Corrected key
      "assignedStudents": assignedStudents,
      "marksSubmitted": marksSubmitted,
    };
  }

  /// Factory method to create a user from firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['Firstname'] ?? '',
        lastName: data['Lastname'] ?? '',
        username: data['Username'] ?? '',
        email: data["Email"] ?? '',
        phoneNo: data["Phone"] ?? '',
        profilePicture: data['Profile picture'] ?? '',
        assignedStudents: List<String>.from(data['assignedStudents'] ?? []),
        marksSubmitted: data['marksSubmitted'] ?? false,
      );
    } else {
      return UserModel.empty();
    }
  }
}
