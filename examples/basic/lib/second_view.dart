import 'package:crow/crow.dart' show DefaultViewModel, View;
import 'package:flutter/material.dart';

class SecondPage extends View<DefaultViewModel> {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Go back'),
      ),
    );
  }
}
