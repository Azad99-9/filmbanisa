import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmbanisa/user_pages/signup_page/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignupPage extends StackedView<SignupViewModel> {
  const SignupPage({super.key});

  @override
  SignupViewModel viewModelBuilder(BuildContext context) => SignupViewModel();

  @override
  void onViewModelReady(SignupViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
      BuildContext context, SignupViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              backgroundImage: CachedNetworkImageProvider(viewModel.user.photoURL!),
              
            ),
            const SizedBox(height: 20),
            TextField(
              controller: viewModel.usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: viewModel.isFormValid ? () {
                viewModel.submitForm(context);
              } : null,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
