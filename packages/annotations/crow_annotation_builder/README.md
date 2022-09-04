## crow_annotation_builder

[![Github stars](https://img.shields.io/github/stars/elbeicktalat/crow?logo=github)](https://github.com/elbeicktalat/crow/tree/master/packages/annotations/crow_annotation_builder)
[![Pub Version](https://img.shields.io/pub/v/crow_annotation_builder?color=blue&logo=dart)](https://pub.dev/packages/crow_annotation_builder)

The maker of the magic of crow_annotation.

## crow_annotation

[![Github stars](https://img.shields.io/github/stars/elbeicktalat/crow?logo=github)](https://github.com/elbeicktalat/crow/tree/master/packages/annotations/crow_annotation)
[![Pub Version](https://img.shields.io/pub/v/crow_annotation?color=blue&logo=dart)](https://pub.dev/packages/crow_annotation)

## Installation

1) Add this to your packages pubspec.yaml file:

```yaml
# The annotation
dependencies:
  crow_annotation: <^last>

# The maker of the magic.
dev_dependencies:
  crow_annotation_builder: <^last>
  build_runner: <^last>
```

2) Install it You can install it from the command line:

```bash
$ dart pub get
```

3) Enjoy!

```bash
flutter packages pub run build_runner build
## or
flutter packages pub run build_runner watch
```