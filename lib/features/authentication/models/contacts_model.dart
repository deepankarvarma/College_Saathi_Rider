
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactsModel {
  // Keep those values final which you do not want to update
  final String details;
  final String email;
  final String name;
  
  /// Constructor for UserModel.
  ContactsModel({
    required this.details,
    required this.email,
    required this.name,
    
  });
  static ContactsModel empty() => ContactsModel(
        details: '',
        email: '',
        name: '',
      );

  // Convert RequestModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Email': email,
      'Details': details,
      
    };
  }

  // Factory method to create a RequestModel from a Firebase document snapshot
  factory ContactsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ContactsModel(
        name: data['Name'] ?? '',
        email: data['Email'] ?? '',
        details: data['Details'] ?? '',
        
      );
    } else {
      return ContactsModel.empty();
    }
  }
}

