import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepositoryProvider = Provider(
  (ref) => CommonFirebaseStorageRepository(
    firebaseStorage: FirebaseStorage.instance,
  ),
);

class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  CommonFirebaseStorageRepository({
    required this.firebaseStorage,
  });

  init() {
    firebaseStorage.setMaxUploadRetryTime(Duration(milliseconds: 500));
  }

  Future<String> storeFileToFirebase(String path, File file) async {
    print('adasdasd ${firebaseStorage.bucket}');
    print('adasdasd ${firebaseStorage.app}');
    print('adasdasd ${firebaseStorage.app.name}');
    print('adasdasd ${firebaseStorage.ref()}');
    print('adasdasd ${firebaseStorage.ref().fullPath}');
    print('adasdasd ${firebaseStorage.ref()}');
    print('adasdasd ${firebaseStorage.toString()}');
    print('adasdasd ${file.path}');
    print('adasdasd123');
    TaskSnapshot snap = await firebaseStorage.ref().child(path).putFile(file);
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
