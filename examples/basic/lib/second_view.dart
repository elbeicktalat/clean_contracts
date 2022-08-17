import 'package:crow/core/presentation/view/stateless/view.dart';
import 'package:crow/core/presentation/view_model/view_model.dart';
import 'package:flutter/material.dart';

class SecondPage extends View<BasicViewModel> {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return const Scaffold(
      body: Center(
        child: Text('Go back'),
      ),
    );
  }
}
