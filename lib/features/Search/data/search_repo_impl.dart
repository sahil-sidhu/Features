import 'package:chambas/features/Profile/domain/models/profile_model.dart';
import 'package:chambas/features/Search/domain/search_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//Import firebase core.

class SearchRepoImpl extends SearchRepo {
  @override
  Future<List<ProfileModel?>> searchUsers(String query) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection("profiles")
          .where('firstName', isGreaterThanOrEqualTo: query)
          .where('firstName', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      return result.docs
          .map((doc) => ProfileModel.fromFireStore(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      debugPrint('Firebase Error during search: ${e.code}, ${e.message}');
      throw Exception('Firebase search error: ${e.message}');
    } on TypeError catch (e) {
      debugPrint(
          'Type Error during search and model creation: ${e.toString()}');
      throw Exception('Data mapping error: ${e.toString()}');
    } on Exception catch (e) {
      debugPrint('General Exception during search: ${e.toString()}');
      throw Exception('General search error: ${e.toString()}');
    } catch (e) {
      // Catch any other unexpected errors
      debugPrint('Unexpected error during search: ${e.toString()}');
      throw Exception('Unexpected search error: ${e.toString()}');
    }
  }
}
