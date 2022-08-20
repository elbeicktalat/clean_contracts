# crow

[![Github stars](https://img.shields.io/github/stars/elbeicktalat/crow?logo=github)](https://github.com/elbeicktalat/crow)
[![Pub Version](https://img.shields.io/pub/v/auth_buttons?color=blue&logo=dart)](https://pub.dev/packages/crow)

Crow gives you utils widgets, to apply separation of concerns.

## Installation

1) Add this to your packages pubspec.yaml file:

```yaml
dependencies:
  crow: <^last>
```

1) Install it You can install it from the command line:

```bash
$ flutter pub get
```

1) Import it Now in Dart code, you can use:

```dart
import 'package:crow/crow.dart';
```

## Usage

There are two types of `Widgets`:

1. **View** - The `StatelessWidget` implementation but with extra features.
2. **Screen** - The responsive version of `View`, which offers more utils.
   You will find only `View` examples,
   but `Screen` are the same except they have more method for the build. Like: mobile(), tablet() etc.

### Start

1. First of all At the top of your main method you need to call Crow initDependencies,
   which will allows you getting benefits of preregistered dependencies.
2. Define your View.
3. If you need custom viewModel then set the View generic type to the ViewModel which you have been created.
4. Register your ViewModel as a dependency.
5. Enjoy crow!.

```dart
// The Stateless example of Crow package. 
// Try to discover the others by your self 😉 I'm joking!

void main() {
  Crow.instance.initDependencies();
  GetIt.instance.registerLazySingleton<HomeViewModel>(HomeViewModel.new); // Or
  // GetIt.instance.registerLazySingleton<HomeViewModel>(() => HomeViewModel()); same thing.
}

// Remember to set the View generic `Type` in order to accesses your custom properties,
// getters, setters, methods in your Widget. As below HomeViewModel is subclass of ViewModel.
// If you don't specify the View generic `Type` then you'll be able to accesses only predefined stuff. e.g a context getter. 
class HomeView extends View<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  // Note: that you can assess the BuildContext globally in your widget.
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

// Remember what we have side?
// The type parameter on View is optional, so in this case you cannot access custom invocation,
// but still able to get the predefined ones like the global context.
class SecondPage extends View {
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
```

The View Stateful Example:

```dart
void main() {
  // Crow.instance.initDependencies(); // un like before there are no preregistered StateViewModel.
  GetIt.instance.registerLazySingleton<HomeViewModel>(HomeViewModel.new);
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

// since you want to use the Sate methods than the HomeViewModel is a subclass of `StateViewModel`.
class _MyHomePageState extends ViewState<MyHomePage, HomeViewModel>
    with SingleTickerProviderStateMixin {
  // declare this here and not in the ViewModel because of vsync property.
  late TabController tabController;

  // Note you don't need to call any State method, we are doing this because of vsync property. 
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
```