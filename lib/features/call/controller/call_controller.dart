import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familychat/features/auth/controllers/email_controller.dart';
import 'package:familychat/features/call/repositories/call_repository.dart';
import 'package:familychat/models/call_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final callControllerProvider = Provider((ref) {
  final callRepository = ref.read(callRepositoryProvider);
  return CallController(
    callRepository: callRepository,
    auth: FirebaseAuth.instance,
    ref: ref,
  );
});

class CallController {
  final CallRepository callRepository;
  final ProviderRef ref;
  final FirebaseAuth auth;

  CallController({
    required this.callRepository,
    required this.ref,
    required this.auth,
  });

  Stream<DocumentSnapshot> get callStream => callRepository.callStream;

  void makeCall(BuildContext context, String receiverName, String receiverUid, String receiverProfilePic, String type,
      bool isGroupChat) {
    ref.read(userDataProvider).whenData((value) {
      String callId = const Uuid().v1();
      CallModel senderCallData = CallModel(
        callerId: auth.currentUser!.uid,
        callerName: value!.userName,
        callerPic: value.profilePic,
        receiverId: receiverUid,
        receiverName: receiverName,
        receiverPic: receiverProfilePic,
        callId: callId,
        hasDialed: true,
      );

      CallModel recieverCallData = CallModel(
        callerId: auth.currentUser!.uid,
        callerName: value.userName,
        callerPic: value.profilePic,
        receiverId: receiverUid,
        receiverName: receiverName,
        receiverPic: receiverProfilePic,
        callId: callId,
        hasDialed: false,
      );
      if (isGroupChat) {
        // callRepository.makeGroupCall(senderCallData, context, recieverCallData);
      } else {
        callRepository.makeCall(context, senderCallData, recieverCallData, type);
      }
    });
  }

  void endCall(
    String callerId,
    String receiverId,
    BuildContext context,
  ) {
    callRepository.endCall(callerId, receiverId, context);
  }
}
