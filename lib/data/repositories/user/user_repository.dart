import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_saathi_final/data/repositories/authentication/authentication_repository.dart';
import 'package:college_saathi_final/features/authentication/models/contacts_model.dart';
import 'package:college_saathi_final/features/authentication/models/event_model.dart';
import 'package:college_saathi_final/features/authentication/models/user_model.dart';
import 'package:college_saathi_final/features/authentication/models/vendors_model.dart';
import 'package:college_saathi_final/features/personalization/models/request_model.dart';
import 'package:college_saathi_final/utils/exceptions/firebase_exceptions.dart';
import 'package:college_saathi_final/utils/exceptions/format_exceptions.dart';
import 'package:college_saathi_final/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user data to Firestore.
  Future<void> saveUserRecord(DriverModel user) async {
    try {
      await _db.collection("Drivers").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to fetch user details on the basis of User ID
  Future<DriverModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Drivers")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return DriverModel.fromSnapshot(documentSnapshot);
      } else {
        return DriverModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to fetch user details on the basis of User ID
  Future<List<RequestModel>> fetchRequests() async {
    try {
      final querySnapshot = await _db
        .collection("Requests")
        .where("IsAccepted", isEqualTo: false) // Add this filter
        .get();

      final requests = querySnapshot.docs
          .map((doc) => RequestModel.fromSnapshot(doc))
          .toList();

      return requests;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  Future<List<EventsModel>> fetchEvents() async {
    try {
      final querySnapshot = await _db.collection("Events").get();

      final requests = querySnapshot.docs
          .map((doc) => EventsModel.fromSnapshot(doc))
          .toList();

      return requests;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  Future<List<VendorsModel>> fetchVendors() async {
    try {
      final querySnapshot = await _db.collection("Vendors").get();

      final requests = querySnapshot.docs
          .map((doc) => VendorsModel.fromSnapshot(doc))
          .toList();

      return requests;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  Future<List<ContactsModel>> fetchContacts() async {
    try {
      final querySnapshot = await _db.collection("Contacts").get();

      final requests = querySnapshot.docs
          .map((doc) => ContactsModel.fromSnapshot(doc))
          .toList();

      return requests;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<bool> getUserAvailability() async {
    try {
      final documentSnapshot = await _db
          .collection("Drivers")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        // Assuming "Availability" is a boolean field in your Firestore document
        bool userAvailability = documentSnapshot.get('Availability') == true;
        return userAvailability;
      } else {
        return false; // Assuming the default availability is false if the document doesn't exist
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to update user data in firestore
  Future<void> updateUserDetails(DriverModel updatedUser) async {
    try {
      await _db
          .collection("Drivers")
          .doc(updatedUser.id)
          .set(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Update any field in specific user collection
  Future<void> updateAvailabilityStatus(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Drivers")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Update any field in specific user collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Drivers")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to remove user data from firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Drivers").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
