import 'package:filmbanisa/constants/routes.dart';
import 'package:filmbanisa/models/user.dart';
import 'package:filmbanisa/services/auth_service.dart';
import 'package:filmbanisa/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

class SignupViewModel extends BaseViewModel {
  final TextEditingController usernameController = TextEditingController();
  late UserModel user;

  bool isSigningUp = false;

  init() {
    usernameController.text = AuthService.currentUser!.displayName!;
    user = UserModel(
      id: AuthService.currentUser!.uid,
      displayName: usernameController.text,
      email: AuthService.currentUser!.email!,
      createdAt: DateTime.now(),
      photoURL: AuthService.currentUser!.photoURL ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToiRnzzyrDtkmRzlAvPPbh77E-Mvsk3brlxQ&s'
    );
  }
  
  bool get isFormValid => 
      usernameController.text.isNotEmpty;


  Future<void> submitForm(BuildContext context) async {
    isSigningUp = true;
    notifyListeners();
    if(isFormValid) {
      await UserService().createUser(user);
      GoRouter.of(context).pushNamed(Routes.home);
    }
    isSigningUp = false;
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }
}