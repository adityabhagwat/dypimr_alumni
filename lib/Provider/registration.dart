import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference alumni_details_collecttion =
      FirebaseFirestore.instance.collection('Alumni_Details');

  Future<void> updateUserData(
      String name,
      String email,
      String dob,
      String gender,
      String branch,
      int passingYear,
      String approvedProfileStatus) async {
    return await alumni_details_collecttion.doc(uid).set({
      'name': name,
      'email': email,
      'dob': dob,
      'gender': gender,
      'branch': branch,
      'passingYear': passingYear,
      'approvedProfileStatus': approvedProfileStatus
    });
  }
}
