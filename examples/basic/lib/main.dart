import 'package:basic/home_view_model.dart';
import 'package:clean_contracts/core/presentation/view/stateless/screen.dart';
import 'package:clean_contracts/core/presentation/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.instance.registerSingleton<HomeViewModel>(HomeViewModel());
  GetIt.instance.registerSingleton<BasicViewModel>(BasicViewModel());
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
    );
  }
}

class HomeView extends Screen<HomeViewModel> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget? builder() {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: viewModel.navToNext, // Your custom method.
          child: const Text('Go Next'),
        ),
      ),
    );
  }
}
