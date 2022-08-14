# clean_contracts

[![Github stars](https://img.shields.io/github/stars/elbeicktalat/clean_contracts?logo=github)](https://github.com/elbeicktalat/clean_contracts)

Clean contracts gives you utils interfaces and some widgets, in order to apply separation of
concerns.

## Versions

clean_contracts comes with various versions to adapts on your needs.

1. flutter_clean_contracts
2. riverpod_clean_contracts

### flutter_clean_contracts

Let you deal with pure flutter state management, StatefulWidget, ChangeNotifier.

### riverpod_clean_contracts

It depends on flutter_clean_contracts in order to give you all its utilities, but its also adding
riverpod utils trick e.g: the ViewModel dose have a `WidgetRef` property.

## Installation

1) Add this to your packages pubspec.yaml file:
```yaml
dependencies:
  flutter_clean_contracts: <^last> # or riverpod_clean_contracts: <^last> 
```
1) Install it You can install it from the command line:
```bash
$ flutter pub get
```
1) Import it Now in Dart code, you can use:
```dart
import 'package:flutter_clean_contracts/flutter_clean_contracts.dart';

// if you use flutter riverpod
import 'package:riverpod_clean_contracts/riverpod_clean_contracts.dart';
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
  final String title = 'flutter_clean_contracts';
  
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