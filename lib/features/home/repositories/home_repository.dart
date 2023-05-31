import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = Provider((ref) => HomeRepository(FirebaseFirestore.instance, FirebaseAuth.instance));

class HomeRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  HomeRepository(this.firebaseFirestore, this.firebaseAuth);

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    var usersCollection = await firebaseFirestore.collection('users').get();
    var allUsersList = usersCollection.docs.map((e) => e.data()).toList();
    print('all ${allUsersList}');
    return allUsersList;
  }

  Future<List<Map<String, dynamic>>> getUsersChatCollection() async {
    var chatCollection =
        await firebaseFirestore.collection('users').doc(firebaseAuth.currentUser!.uid).collection('chats').get();
    var chatList = chatCollection.docs.map((e) => e.data()).toList();
    return chatList;
  }

  void changeOnlineStatus(bool online) async {
    await firebaseFirestore.collection('users').doc(firebaseAuth.currentUser!.uid).update({'isOnline': online});
  }
}
