import 'package:filmbanisa/user_pages/coins_page/coints_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CoinsPage extends StackedView<CoinsViewModel> {
  const CoinsPage({super.key});

  @override
  CoinsViewModel viewModelBuilder(BuildContext context) => CoinsViewModel();

  @override
  Widget builder(BuildContext context, CoinsViewModel viewModel, Widget? child) {
    return const Scaffold(
      body: Center(child: Text('Coins Page')),
    );
  }
}