import 'package:clean_contracts/core/presentation/view_model/state_view_model.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends StateViewModel {
  late PageController pageViewController;

  @override
  void initState() {
    super.initState();
    pageViewController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }
}
