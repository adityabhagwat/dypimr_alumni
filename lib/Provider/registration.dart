import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference alumni_details_collecttion =
      FirebaseFirestore.instance.collection('Users');

  Future<void> updateUserData(
      String name,
      String email,
      String dob,
      String gender,
      String branch,
      String batch,
      String approvedProfileStatus,
      String userType) async {
    return await alumni_details_collecttion.doc(uid).set({
      'name': name,
      'email': email,
      'dob': dob,
      'gender': gender,
      'branch': branch,
      'batch': batch,
      'approvedProfileStatus': approvedProfileStatus,
      'userType': userType
    });
  }

  Future<void> updateFacultyData(String name, String email, String dob,
      String gender, String branch, String userType) async {
    return await alumni_details_collecttion.doc(uid).set({
      'name': name,
      'email': email,
      'dob': dob,
      'gender': gender,
      'branch': branch,
      'userType': userType
    });
  }
}
