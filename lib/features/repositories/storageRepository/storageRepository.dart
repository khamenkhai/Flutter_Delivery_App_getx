import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepository {
  static Future<String> uploadImage(Uint8List file, String storagePath) async =>
      await FirebaseStorage.instance
          .ref()
          .child(storagePath)
          .putData(file)
          .then((task) => task.ref.getDownloadURL());

  static Future<String> storeFileInFirebase(
      {required Uint8List imageData,
      required String fileName,
      required String path}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child(path).child(fileName);
    UploadTask uploadTask = storageRef.putData(imageData);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }
}
