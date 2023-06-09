import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familychat/features/call/screens/call_screen.dart';
import 'package:familychat/models/call_model.dart';
import 'package:familychat/models/user_model.dart';
import 'package:familychat/services/firebase_services.dart';
import 'package:familychat/widgets/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final callRepositoryProvider = Provider((ref) => CallRepository(FirebaseFirestore.instance, FirebaseAuth.instance));

class CallRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  CallRepository(this.firebaseFirestore, this.firebaseAuth);

  Stream<DocumentSnapshot<Map<String, dynamic>>> get callStream =>
      firebaseFirestore.collection('calls').doc(firebaseAuth.currentUser?.uid).snapshots();

  void makeCall(BuildContext ctx, CallModel senderCallData, CallModel receiverCallData, String callType) async {
    try {
      print('senderCallData.callerId ${senderCallData.callerId}');
      print('senderCallData.callerId ${receiverCallData.callerId}');
      await firebaseFirestore.collection('calls').doc(senderCallData.callerId).set(senderCallData.toMap());
      await firebaseFirestore.collection('calls').doc(receiverCallData.receiverId).set(receiverCallData.toMap());

      sendNotification(from: receiverCallData.toString(), type: callType, uid: receiverCallData.receiverId);
      navigateToCall(ctx, senderCallData);
    } catch (e) {
      snackBar(context: ctx, text: e.toString());
    }
  }

  void endCall(
    String callerId,
    String receiverId,
    BuildContext context,
  ) async {
    try {
      print('senderCallData.callerId 2- $callerId');
      print('senderCallData.callerId 2- $receiverId');
      await firebaseFirestore.collection('calls').doc(callerId).delete();

      await firebaseFirestore.collection('calls').doc(receiverId).delete();

      sendNotification(from: '', type: 'endCall', uid: receiverId);
    } catch (e) {
      print('Error -> $e');
      snackBar(context: context, text: e.toString());
    }
  }

  void navigateToCall(BuildContext ctx, CallModel senderCallData) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (context) => CallScreen(
          channelId: senderCallData.callId,
          call: senderCallData,
          isGroupChat: false,
        ),
      ),
    );
  }

  void sendNotification({uid, type, from}) async {
    var userDataMap = await firebaseFirestore.collection('users').doc(uid).get();
    var receiverToken = UserModel.fromJson(userDataMap.data()!).fcmToken;
    FireMessaging.sendNotification(token: receiverToken, type: type, callData: from);
  }
}
