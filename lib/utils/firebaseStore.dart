import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStore = Provider((ref) => FireBaseStore(fireBaseStorage: FirebaseStorage.instance));

class FireBaseStore {
  final FirebaseStorage fireBaseStorage;

  FireBaseStore({required this.fireBaseStorage});

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = fireBaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
