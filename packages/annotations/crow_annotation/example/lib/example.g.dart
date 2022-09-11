// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// ConverterGenerator
// **************************************************************************

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

// **************************************************************************
// EqualsGenerator
// **************************************************************************

extension _$UserModelEqualsExtension on _UserModel {
  bool $equals(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          email == other.email &&
          phone == other.phone &&
          dateOfBirth == other.dateOfBirth &&
          country == other.country &&
          city == other.city &&
          postalCode == other.postalCode;
}

// **************************************************************************
// HashCodeGenerator
// **************************************************************************

extension _$UserModelHashCodeExtension on _UserModel {
  int $hashCode() =>
      firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      dateOfBirth.hashCode ^
      country.hashCode ^
      city.hashCode ^
      postalCode.hashCode;
}

// **************************************************************************
// SuperGenerator
// **************************************************************************

abstract class _UserModel {
  _UserModel(
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.country,
    this.city,
    this.postalCode,
  );

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

  @override
  int get hashCode => $hashCode();

  @override
  String toString() => $toString();
}

// **************************************************************************
// ToStringGenerator
// **************************************************************************

extension _$UserModelToStringExtension on _UserModel {
  String $toString() =>
      'UserModel{firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, dateOfBirth: $dateOfBirth, country: $country, city: $city, postalCode: $postalCode}';
}
