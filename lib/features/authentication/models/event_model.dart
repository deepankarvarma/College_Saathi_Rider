
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsModel {
  // Keep those values final which you do not want to update
  final String sdate;
  final String edate;
  final String location;
  final String ename;
  
  /// Constructor for UserModel.
  EventsModel({
    required this.sdate,
    required this.edate,
    required this.location,
    required this.ename,
    
  });
  static EventsModel empty() => EventsModel(
        sdate: '',
        edate: '',
        location: '',
        ename:'',
      );

  // Convert RequestModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'Name': ename,
      'Starting Date': sdate,
      'Ending Date': edate,
      'Location': location,
      
    };
  }

  // Factory method to create a RequestModel from a Firebase document snapshot
  factory EventsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return EventsModel(
        sdate: data['Starting Date'] ?? '',
        edate: data['Ending Date'] ?? '',
        location: data['Location'] ?? '',
        ename: data['Name'] ?? '',
        
      );
    } else {
      return EventsModel.empty();
    }
  }
}

