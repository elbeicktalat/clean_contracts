import 'package:flutter/material.dart';
import 'package:crow/crow.dart' show BasicViewModel, View;

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
