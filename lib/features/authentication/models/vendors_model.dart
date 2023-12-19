
import 'package:cloud_firestore/cloud_firestore.dart';

class VendorsModel {
  // Keep those values final which you do not want to update
  final String location;
  final String phone;
  final String name;
  final String type;
  
  /// Constructor for UserModel.
  VendorsModel({
    required this.location,
    required this.phone,
    required this.name,
    required this.type,
    
  });
  static VendorsModel empty() => VendorsModel(
        location: '',
        phone: '',
        name: '',
        type: '',
      );

  // Convert RequestModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Location': location,
      'Phone': phone,
      'Type': type,
      
    };
  }

  // Factory method to create a RequestModel from a Firebase document snapshot
  factory VendorsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return VendorsModel(
        name: data['Name'] ?? '',
        phone: data['Phone'] ?? '',
        type: data['Location'] ?? '',
        location: data['Type'] ?? '',
        
      );
    } else {
      return VendorsModel.empty();
    }
  }
}

