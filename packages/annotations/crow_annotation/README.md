## crow_annotation

[![Github stars](https://img.shields.io/github/stars/elbeicktalat/crow?logo=github)](https://github.com/elbeicktalat/crow/tree/master/packages/annotations/crow_annotation)
[![Pub Version](https://img.shields.io/pub/v/crow_annotation?color=blue&logo=dart)](https://pub.dev/packages/crow_annotation)

Set of utils annotations which will save you the pain of writing boring code.

## Installation

1) Add this to your packages pubspec.yaml file:

```yaml
dependencies:
  crow_annotation: <^last>

# The maker of the magic.
dev_dependencies:
  crow_annotation_builder: <^last>
```

2) Install it You can install it from the command line:

```bash
$ dart pub get
```

3) Import it Now in Dart code, you can use:

```dart
import 'package:crow_annotation/crow_annotation.dart';
```

## annotations

### Converter

Allows you converting between object types. Think about it like Converting dart object to/from JSON,
but this is totally dart conversation.

```dart
// In this example as you'll see that we are converting CurrentModel to/from Current.
// NOTE: THE ORDER OF THE PARAMS IN THE CONTRACTURE DOSE MATTER, TYPE OBJECT ALSO MATTER.
@Converter(User)
class UserModel {
  UserModel(this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.country,
      this.city,
      this.postalCode,);

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final String country;
  final String city;
  final String postalCode;


  /// Point to _$UserModelFromUser and enjoy your UserModel got from User.
  factory UserModel.fromUser(User user) => _$UserModelFromUser(user);

  /// Point to _$UserModelToUser and enjoy your UserModel got to User.
  User toUser() => _$UserModelToUser(this);
}

class User {
  User(this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.country,
      this.city,
      this.postalCode,);

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final String country;
  final String city;
  final String postalCode;
}

// generated result:
/// Returns an object of the annotated class, it gets it's value from the target convert.
UserModel _$UserModelFromUser(User instance) {
  return UserModel(
    instance.firstName,
    instance.lastName,
    instance.email,
    instance.phone,
    instance.dateOfBirth,
    instance.country,
    instance.city,
    instance.postalCode,
  );
}

/// Returns an object of the target convert class, it gets it's value from the annotated class.
User _$UserModelToUser(UserModel instance) {
  return User(
    instance.firstName,
    instance.lastName,
    instance.email,
    instance.phone,
    instance.dateOfBirth,
    instance.country,
    instance.city,
    instance.postalCode,
  );
}
```

And what if I'm converting a lists or objects? no worries they are handheld.

```dart

@Converter(Current)
class CurrentModel {
  const CurrentModel(this.coordinates,
      this.weathers,
      this.date,
      this.cityName,);

  final CoordinatesModel coordinates;
  final List<WeatherModel> weathers;
  final DateTime date;
  final String cityName;
}

class Current {
  const Current(this.coordinates,
      this.weathers,
      this.date,
      this.cityName,);

  final Coordinates coordinates;
  final List<Weather> weathers;
  final DateTime date;
  final String cityName;
}

// generated result:

/// Returns an object of the annotated class, it gets it's value from the target convert.
CurrentModel _$CurrentModelFromCurrent(Current instance) {
  return CurrentModel(
    CoordinatesModel.fromEntity(instance.coordinates),
    instance.weathers.map((e) => WeatherModel.fromWeather(e)).toList(),
    instance.date,
    instance.cityName,
  );
}

/// Returns an object of the target convert class, it gets it's value from the annotated class.
Current _$CurrentModelToCurrent(CurrentModel instance) {
  return Current(
    instance.coordinates.toEntity(),
    instance.weathers.map((e) => e.toWeather()).toList(),
    instance.date,
    instance.cityName,
  );
}
```

### ToString

Allows you get rid of boring [toString] overriding, Ides does the same, but with this annotation
hide the so long string to make your class more cleaner and if you change the class property you
have no worries.

```dart
@ToString()
class User {
  User(this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.country,
      this.city,
      this.postalCode,);

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final String country;
  final String city;
  final String postalCode;

  @override
  String toString() => $toString();
}
// generated result:
String $toString() =>
    'UserModel{firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, dateOfBirth: $dateOfBirth, country: $country, city: $city, postalCode: $postalCode}';
```

You can exclude fields by name or by visibility, by defaults privet property are included.

### Equals

```dart
@Equals()
class User {
  User(this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.country,
      this.city,
      this.postalCode,);

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final String country;
  final String city;
  final String postalCode;

  @override
  bool operator ==(Object other) => $equals(other);
}

// generated result:
bool $equals(Object other) =>
    identical(this, other) ||
        other is User &&
            runtimeType == other.runtimeType &&
            firstName == other.firstName &&
            lastName == other.lastName &&
            email == other.email &&
            phone == other.phone &&
            dateOfBirth == other.dateOfBirth &&
            country == other.country &&
            city == other.city &&
            postalCode == other.postalCode;
```

You can exclude fields by name or ignoreAll fields, by defaults all fields are included. NOTE: if
you ignoreAll fields the runtimeType == other.runtimeType stills included.

### HashCode

```dart
@HashCode()
class User {
  User(this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.country,
      this.city,
      this.postalCode,);

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final String country;
  final String city;
  final String postalCode;

  @override
  int get hashCode => $hashCode();
}

// generate result:
int $hashCode() =>
    firstName.hashCode ^
    lastName.hashCode ^
    email.hashCode ^
    phone.hashCode ^
    dateOfBirth.hashCode ^
    country.hashCode ^
    city.hashCode ^
    postalCode.hashCode;
```

You can exclude fields by name, by defaults all fields are included.