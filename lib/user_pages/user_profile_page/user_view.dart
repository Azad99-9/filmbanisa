import 'package:filmbanisa/user_pages/user_profile_page/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UserProfilePage extends StackedView<UserProfileViewModel> {
  const UserProfilePage({super.key});

  @override
  UserProfileViewModel viewModelBuilder(BuildContext context) => UserProfileViewModel();

  @override
  Widget builder(BuildContext context, UserProfileViewModel viewModel, Widget? child) {
    return const Scaffold(
      body: Center(child: Text('User Profile Page')),
    );
  }
}