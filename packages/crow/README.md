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

## Offers

### contracts (interfaces)

- data layer
    - Model
    - RemoteDataSource
    - LocalDataSource
- domain layer
    - Entity
    - Service
    - UseCase
- presentation layer
    - middleware
    - page
    - screen
    - view
    - view_model
- generic
    - crud_operation
    - params
    - repository

### Services

- connectivity_service
- preferences_service
- theme_mode_service

## Usage

There are two types of `Widgets`:

1. **View** - The `StatelessWidget` implementation but with extra features.
2. **Screen** - The responsive version of `View`, which offers more utils. You will find only `View`
   examples, but `Screen` are the same except they have more method for the build. Like: phone(),
   tablet() etc.

### Start

1. First of all At the top of your main method you need to call Crow initDependencies, which will
   allows you getting benefits of preregistered dependencies.
2. Define your View.
3. If you need custom viewModel then set the View generic type to the ViewModel which you have been
   created.
4. Register your ViewModel as a dependency.
5. Enjoy crow!.

```dart
void main() async {
  await Crow.instance.initAsyncServices();
  Crow.instance.initDependencies();
  Get.lazyPut<HomeViewModel>(HomeViewModel.new); // Or
  // Get.lazyPut<HomeViewModel>(() => HomeViewModel()); same thing.
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