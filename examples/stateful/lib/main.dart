import 'package:crow/crow.dart' show ViewState;
import 'package:flutter/material.dart';
import 'package:stateful/di/di.dart';
import 'package:stateful/home_view_model.dart';

void main() {
  bindings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ViewState<MyHomePage, HomeViewModel>
    with SingleTickerProviderStateMixin {
  // declare this here and not in the ViewModel because of vsync property.
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    // super.initState() calls the super initState(),
    // whose call the ViewModel one.
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: viewModel.pageViewController.initialPage,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget? builder() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: viewModel.pageViewController,
            children: [
              Container(color: Colors.blue),
              Container(color: Colors.teal),
              Container(color: Colors.purple),
            ],
            onPageChanged: (value) {
              // also we cannot setState from the ViewModel,
              // so this is another motivation of the tabController in the State class.
              setState(() {
                tabController.index = value;
              });
            },
          ),
          TabPageSelector(
            controller: tabController,
            color: Colors.white,
            selectedColor: Colors.black,
            borderStyle: BorderStyle.none,
          ),
        ],
      ),
    );
  }
}
