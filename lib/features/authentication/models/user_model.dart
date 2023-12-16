import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_saathi_final/utils/formatters/formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DriverModel {
// Keep those values final which you do not want to update
  final String id;
  String firstName;
  String lastName;
  final String ricknum;
  final String email;
  bool availability;
  String phoneNumber;
  String profilePicture;

  /// Constructor for UserModel.
  DriverModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.availability,
    required this.ricknum,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format phone number.
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername =
        "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "csr_$camelCaseUsername"; // Add
    return usernameWithPrefix;
  }

  /// Static function to create an empty user model.
  static DriverModel empty() => DriverModel(
      id: '',
      firstName: '',
      lastName: '',
      availability: false,
      ricknum: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': ricknum,
      'Email': email,
      'Availability': availability,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  // Factory method to create a UserModel from a Firebase document snapshot
  factory DriverModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return DriverModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        availability: true,
        ricknum: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return DriverModel.empty();
    }
  }
}
