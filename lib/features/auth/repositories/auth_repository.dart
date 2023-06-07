import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familychat/models/user_model.dart';
import 'package:familychat/screens/mobile_layout_screen.dart';
import 'package:familychat/services/firebase_services.dart';
import 'package:familychat/services/paths.dart';
import 'package:familychat/widgets/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      firebaseFireStore: FirebaseFirestore.instance,
      firebaseAuth: FirebaseAuth.instance,
    ));

class AuthRepository {
  final FirebaseFirestore firebaseFireStore;
  final FirebaseAuth firebaseAuth;

  AuthRepository({required this.firebaseFireStore, required this.firebaseAuth});

  signInWithPhone(BuildContext ctx, String phoneNumber) {
    print('signInWithPhone');
    try {
      firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {
          firebaseAuth.signInWithCredential(phoneAuthCredential);
          print('verificationCompleted $phoneAuthCredential');
        },
        verificationFailed: (error) {
          print('verificationFailed $error');
        },
        codeSent: (verificationId, forceResendingToken) {
          navigateToOtp(ctx, verificationId);
          print('codeSent $verificationId');
        },
        codeAutoRetrievalTimeout: (verificationId) {
          print('codeAutoRetrievalTimeout $verificationId');
        },
      );
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException');
      snackBar(context: ctx, text: e.message ?? 'SomeThing Went Wrong!!');
    }
  }

  void signInWithEmail(BuildContext ctx, String email, String password) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() => Navigator.pushNamedAndRemoveUntil(
                ctx,
                Paths.homeScreen,
                (route) => false,
              ));
    } catch (e) {
      print('signInWithEmail error :: $e');
    }
  }

  Future signOut(BuildContext ctx) async {
    try {
      await firebaseAuth.signOut().whenComplete(() => Navigator.popAndPushNamed(ctx, Paths.landingScreen));
    } catch (e) {
      print('signInWithEmail error :: $e');
    }
  }

  void signUp(BuildContext ctx, String email, String password) {
    try {
      firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).whenComplete(() async {
        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      }).whenComplete(() => Navigator.pushNamedAndRemoveUntil(
            ctx,
            Paths.userInfoScreen,
            (route) => false,
          ));
    } catch (e) {
      print('signInWithEmail error :: $e');
    }
  }

  addUserData(BuildContext ctx, UserModel user) {
    var uid = firebaseAuth.currentUser!.uid;

    firebaseFireStore.collection('users').doc(uid).set(user.toJson());
  }

  navigateToOtp(BuildContext context, String verificationId) {
    Navigator.pushNamed(context, Paths.otpScreen, arguments: verificationId);
  }

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      print('current user uid $uid');
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

      if (profilePic != null) {
        photoUrl = await ref.read(commonFirebaseStorageRepositoryProvider).storeFileToFirebase(
              'profilePic/$uid',
              profilePic,
            );
      }

      var user = UserModel(
        uid: uid,
        profilePic: photoUrl,
        isOnline: false,
        groupId: [],
        userName: name,
        fcmToken: '',
        email: firebaseAuth.currentUser!.email!,
      );

      await firebaseFireStore.collection('users').doc(uid).set(user.toJson()).whenComplete(() {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MobileLayoutScreen(),
          ),
          (route) => false,
        );
      });
      await firebaseFireStore.collection('users').doc(uid).update(user.toJson()).whenComplete(() {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MobileLayoutScreen(),
          ),
          (route) => false,
        );
      });
    } catch (e) {
      snackBar(context: context, text: e.toString());
    }
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData = await firebaseFireStore.collection('users').doc(firebaseAuth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromJson(userData.data()!);
    }
    return user;
  }

  Future<List<Map<String, dynamic>>> getAllUserData() async {
    var userData = await firebaseFireStore.collection('users').get();
    var dataList = userData.docs.map((e) => e.data()).toList();
    return dataList;
  }

  Stream<UserModel> userData(String userId) {
    return firebaseFireStore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromJson(
            event.data()!,
          ),
        );
  }

  Future addFCMToken(String token) async {
    await firebaseFireStore.collection('users').doc(firebaseAuth.currentUser?.uid).update({'fcmToken': token});
  }
}
