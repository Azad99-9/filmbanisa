import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmbanisa/constants/routes.dart';
import 'package:filmbanisa/services/auth_service.dart';
import 'package:filmbanisa/services/db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

class SigninViewModel extends BaseViewModel {
  final CollectionReference usersCollection = DbService.usersCollection;

  bool signingIn = false;

  Future<void> handleGoogleSignIn(BuildContext context) async {
    signingIn = true;
    notifyListeners();

    await AuthService.signInWithGoogle();

    final snapshot = await usersCollection.doc(AuthService.currentUser?.uid).get();
    if (snapshot.exists) {
      GoRouter.of(context).pushReplacementNamed(Routes.home);
    } else {
      GoRouter.of(context).pushReplacementNamed(Routes.signup);
    }
    signingIn = false;
    notifyListeners();
  }
}
