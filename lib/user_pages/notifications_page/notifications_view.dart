import 'package:filmbanisa/user_pages/notifications_page/notifications_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NotificationsPage extends StackedView<NotificationsViewModel> {
  const NotificationsPage({super.key});

  @override
  NotificationsViewModel viewModelBuilder(BuildContext context) => NotificationsViewModel();

  @override
  Widget builder(BuildContext context, NotificationsViewModel viewModel, Widget? child) {
    return const Scaffold(
      body: Center(child: Text('Notifications Page')),
    );
  }
}