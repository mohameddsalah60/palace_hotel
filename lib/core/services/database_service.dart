abstract class DatabaseService {
  Future<void> initialize();

  Future<void> addData({
    String? docId,
    required String path,
    String? subPath,
    required Map<String, dynamic> data,
  });

  Future<dynamic> getData({
    required String path,
    String? uId,
    String? subPath,
    Map<String, dynamic>? query,
  });

  Future<bool> checkIfDataExists({required String path, required String docId});

  Future<void> updateData({
    required String path,
    String? supPath,
    required Map<String, dynamic> oldVALUE,
    dynamic newVALUE,
  });

  Future<void> deleteData({
    required String path,
    String? supPath,
    dynamic value,
  });
}
