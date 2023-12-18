
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  // Keep those values final which you do not want to update
  final String id;
  final String source;
  final String destination;
  final bool isAccepted;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  /// Constructor for UserModel.
  RequestModel({
    required this.id,
    required this.source,
    required this.destination,
    required this.isAccepted,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });
  static RequestModel empty() => RequestModel(
        id: '',
        source: '',
        destination: '',
        isAccepted: true,
        firstName: '',
        lastName: '',
        email: '',
        phoneNumber: '',
      );

  // Convert RequestModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'User Id': id,
      'Source': source,
      'Destination': destination,
      'Is Accepted': isAccepted,
      'First Name': firstName,
      'Last Name': lastName,
      'Email': email,
      'Phone Number': phoneNumber,
    };
  }

  // Factory method to create a RequestModel from a Firebase document snapshot
  factory RequestModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return RequestModel(
        id: document.id,
        source: data['Source'] ?? '',
        destination: data['Destination'] ?? '',
        isAccepted: data['Is Accepted'] ?? false,
        firstName: data['First Name'] ?? '',
        lastName: data['Last Name'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['Phone Number'] ?? '',
      );
    } else {
      return RequestModel.empty();
    }
  }
}

