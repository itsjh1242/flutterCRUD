import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  late String studentName, studentID, studyProgramID, studentGPA;

  User({
    required this.studentName,
    required this.studentID,
    required this.studyProgramID,
    required this.studentGPA
  });

  static User fromJson(Map<String, dynamic> json) => User(
    studentName: json['studentName'],
    studentID: json['studentID'],
    studyProgramID: json['studyProgramID'],
    studentGPA: json['studentGPA']
  );
}