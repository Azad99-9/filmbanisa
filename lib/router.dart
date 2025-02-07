import 'package:filmbanisa/constants/routes.dart';
import 'package:filmbanisa/models/movie.dart';
import 'package:filmbanisa/user_pages/coins_page/coins_view.dart';
import 'package:filmbanisa/user_pages/home_page/home_view.dart';
import 'package:filmbanisa/user_pages/movie_page/movie_view.dart';
import 'package:filmbanisa/user_pages/notifications_page/notifications_view.dart';
import 'package:filmbanisa/user_pages/signin_page/signin_view.dart';
import 'package:filmbanisa/user_pages/signup_page/signup_view.dart';
import 'package:filmbanisa/user_pages/splash_page.dart';
import 'package:filmbanisa/user_pages/user_profile_page/user_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

String getRoute(String route) {
  return '/$route';
}

final router = GoRouter(
  initialLocation: getRoute(Routes.splash),
  routes: <GoRoute>[
    GoRoute(path: getRoute(Routes.splash),
    name: Routes.splash,
     builder: (context, state) => const SplashPage()),
    GoRoute(path: getRoute(Routes.home),
    name: Routes.home,
     builder: (context, state) => const HomePage()),
    GoRoute(path: getRoute(Routes.movies),
    name: Routes.movies,
     builder: (context, state) => MoviesPage(movie: state.extra as Movie)),
    GoRoute(
      path: getRoute(Routes.userProfile),
      name: Routes.userProfile,
      builder: (context, state) => const UserProfilePage(),
    ),
    GoRoute(
      path: getRoute(Routes.notifications),
      name: Routes.notifications,
      builder: (context, state) => const NotificationsPage(),
    ),
    GoRoute(
      path: getRoute(Routes.coinsInfo),
      name: Routes.coinsInfo,
      builder: (context, state) => const CoinsPage(),
    ),
    GoRoute(
      path: getRoute(Routes.signin) ,
      name: Routes.signin,
      builder: (context, state) => const SigninPage(),
    ),
    GoRoute(
      path: getRoute(Routes.signup),
      name: Routes.signup,
      builder: (context, state) => const SignupPage(),
    ),
  ],
);
