import 'package:basic/second_view.dart';
import 'package:crow/core/presentation/view_model/view_model.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ViewModel {
  final String title = 'flutter_crow';

  void navToNext() {
    Navigator.push(
      context, // You can accesses the BuildContext globally in your ViewModel.
      MaterialPageRoute(
        builder: (context) {
          return const SecondPage();
        },
      ),
    );
  }
}
