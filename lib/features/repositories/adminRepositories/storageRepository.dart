import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

// class StorageRepository {
//   final FirebaseStorage firebaseStorage;

//   StorageRepository({required this.firebaseStorage});


// Future<String> storeFileInFirebase({
//   required String path,
//   required String fileName,
//   required Uint8List imageData,
// }) async {
//   try {
//     //Uint8List? image = await compressImage(imageData);
//     final ref = FirebaseStorage.instance.ref().child(path).child(fileName);
//     UploadTask uploadTask = ref.putData(imageData);
//     final snapshot = await uploadTask;
//     return snapshot.ref.getDownloadURL();
//   } catch (e) {
//     throw Exception(e);
//   }
// }
//upload image to firebase storage
  Future<String> storeFileInFirebase({required Uint8List imageData, required String fileName,required String path}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child(path).child(fileName);
    UploadTask uploadTask = storageRef.putData(imageData);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }





Future<Uint8List?> compressImage(Uint8List imageData) async {
  List<int> compressedData = await FlutterImageCompress.compressWithList(
    imageData,
    quality: 65,
  );
  return Uint8List.fromList(compressedData);
}


