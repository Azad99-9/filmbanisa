import 'package:filmbanisa/constants/routes.dart';
import 'package:filmbanisa/services/auth_service.dart';
import 'package:filmbanisa/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      if (AuthService.currentUser != null) {
        final user = await UserService().getUser(AuthService.currentUser!.uid);
        if (user != null) {
          context.pushReplacementNamed(Routes.home);
        } else {
          context.pushReplacementNamed(Routes.signup);
        }
      } else {
        context.pushReplacementNamed(Routes.signin);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Splash Page'));
  }
}
