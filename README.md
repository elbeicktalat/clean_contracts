# crow

[![Github stars](https://img.shields.io/github/stars/elbeicktalat/crow?logo=github)](https://github.com/elbeicktalat/crow)

Crow gives you utils widgets, in order to apply separation of concerns.

## Versions

crow comes with various versions to adapts on your needs.

1. crow
2. riverpod_crow

### crow

Let you deal with pure flutter state management, `StatefulWidget`, `ChangeNotifier`.

### riverpod_crow

It depends on `crow` in order to give you all its utilities, but its also adding
riverpod utils trick e.g: the ViewModel dose have a `WidgetRef` property.

## Installation

1) Add this to your packages pubspec.yaml file:
```yaml
dependencies:
  crow: <^last> # or riverpod_crow: <^last> 
```
1) Install it You can install it from the command line:
```bash
$ flutter pub get
```
1) Import it Now in Dart code, you can use:
```dart
import 'package:crow/crow.dart';

// if you use flutter riverpod
import 'package:riverpod_crow/riverpod_crow.dart';
```

## Usage

1. Define your View and ViewModel.
2. Set the View generic type to the ViewModel which you have been create e.g: View<HomeViewModel>.
3. Register your ViewModel as a dependency.
4. Enjoy it.

```dart
void main() {
  GetIt.instance.registerSingleton<HomeViewModel>(HomeViewModel());
}

// Remember to set the View generic `Type` in order to accesses your custom properties,
// getters, setters, methods in your Widget. As below HomeViewModel is subclass of ViewModel.
// If you don't specify the View generic `Type` then you'll be able to accesses only predefined stuff.
class HomeView extends View<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

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

// BasicViewModel is the predefined ViewModel, use this if you haven't custom stuff. 
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
```