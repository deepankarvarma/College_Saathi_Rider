import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_saathi_final/utils/formatters/formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class RequestModel {
// Keep those values final which you do not want to update
  final String id;
  final String source;
  final String destination;
  final bool isAccepted;

  /// Constructor for UserModel.
  RequestModel({
    required this.id,
    required this.source,
    required this.destination,
    required this.isAccepted,

  });


  /// Static function to create an empty user model.
  static RequestModel empty() => RequestModel(
      id: '',
      source: '',
      destination: '',
      isAccepted: true,
  );

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'User Id': id,
      'Source': source,
      'Destination': destination,
      'Is Accepted': isAccepted,
      
    };
  }

  // Factory method to create a UserModel from a Firebase document snapshot
  factory RequestModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return RequestModel(
        id: document.id,
        source: data['Source'] ?? '',
        destination: data['Destination'] ?? '',
        isAccepted: data['Is Accepted'] ?? '',
        
      );
    } else {
      return RequestModel.empty();
    }
  }
}