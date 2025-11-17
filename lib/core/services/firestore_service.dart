import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database_service.dart';

class FirestoreService implements DatabaseService {
  FirebaseFirestore firestoreService = FirebaseFirestore.instance;

  @override
  Future<void> initialize() async {
    log("🔹 Firestore initialized for app: ${firestoreService.app.name}");
    return Future.value();
  }

  @override
  Future<void> addData({
    required String path,
    String? docId,
    String? subPath,
    required Map<String, dynamic> data,
  }) async {
    try {
      if (docId != null) {
        await firestoreService.collection(path).doc(docId).set(data);
        log("✅ Successfully added with docId: $docId");
      } else {
        DocumentReference ref = await firestoreService
            .collection(path)
            .add(data);
        log("✅ Successfully added with auto-generated docId: ${ref.id}");
      }
    } catch (e, st) {
      log("❌ Failed to add data: $e\n$st");
      rethrow;
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    String? uId,
    String? subPath,
    Map<String, dynamic>? query,
  }) async {
    try {
      if (uId != null) {
        var doc = await firestoreService.collection(path).doc(uId).get();
        return doc.data();
      }

      Query<Map<String, dynamic>> q = firestoreService.collection(path);
      if (query != null) {
        if (query['where'] != null && query['isEqualTo'] != null) {
          q = q.where(query['where'], isEqualTo: query['isEqualTo']);
        }
        if (query['orderBy'] != null) {
          q = q.orderBy(
            query['orderBy'],
            descending: query['descending'] ?? false,
          );
        }
      }

      var snapshot = await q.get();
      return snapshot.docs.map((e) => e.data()).toList();
    } catch (e, st) {
      log("❌ getData failed for path $path: $e\n$st");
      rethrow;
    }
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String docId,
  }) async {
    try {
      var doc = await firestoreService.collection(path).doc(docId).get();
      return doc.exists;
    } catch (e) {
      log("❌ checkIfDataExists failed for $path/$docId: $e");
      return false;
    }
  }

  @override
  Future<void> updateData({
    required String path,
    String? supPath,
    required Map<String, dynamic> oldVALUE,
    dynamic newVALUE,
  }) async {
    try {
      await firestoreService.collection(path).doc(supPath).update(oldVALUE);
      log("✅ Updated doc: $supPath in $path with $oldVALUE");
    } catch (e, st) {
      log("❌ updateData failed: $e\n$st");
      rethrow;
    }
  }

  @override
  Future<void> deleteData({
    required String path,
    String? supPath,
    dynamic value,
  }) async {
    try {
      await firestoreService.collection(path).doc(value.toString()).delete();
      log("✅ Deleted doc: $value from $path");
    } catch (e, st) {
      log("❌ deleteData failed: $e\n$st");
      rethrow;
    }
  }
}
