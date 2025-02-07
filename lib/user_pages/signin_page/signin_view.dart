import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmbanisa/user_pages/signin_page/signin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SigninPage extends StackedView<SigninViewModel> {
  const SigninPage({super.key});

  @override
  SigninViewModel viewModelBuilder(BuildContext context) => SigninViewModel();

  @override
  Widget builder(BuildContext context, SigninViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                viewModel.handleGoogleSignIn(context);
              },
              icon: CachedNetworkImage(
                imageUrl: 'https://www.google.com/favicon.ico',
                height: 24,
              ),
              label: const Text('Sign in with Google'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}