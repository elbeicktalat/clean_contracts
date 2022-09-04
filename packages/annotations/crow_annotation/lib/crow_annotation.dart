library crow_annotation;

import 'package:meta/meta_meta.dart';

/// Allows you to convert the annotated object to the [objectType] object.
///
/// It's works almost like Json parsing, but here we are parsing Dart objects,
/// this can be helpful if your two objects aren't subclasses of a common parent.
///
/// ```dart
///
/// // The class which will hold the converting logic. You just annotating it with
/// // @Convert and pass the type off the class you wish to convert (To/From).
///
/// // After that you will have tow functions, "annotated class from target" and
/// // "annotated class to target".
///<<<<
/// @Converter(UserEntity)=======
/// class UserModel {
///   UserModel(
///     this.id, {
///     this.name,
///   });
///
///   final int? id;
///   final String? name;
///
///   factory UserModel.fromEntity(UserEntity entity) =>
///       _$UserModelFromUserEntity(entity);
///
///   UserEntity toEntity() => _$UserModelToUserEntity(this);
/// }
///
/// class UserEntity {
///   const UserEntity(
///     this.id, {
///     this.name,
///    });
///
///   final int? id;
///   final String? name;
/// }
///
/// ```
///
/// Its so important to note that the parameters must have the same name, type,
/// position "for the positional parameters".
@Target(<TargetKind>{TargetKind.classType})
class Converter {
  /// Accept a [Type]
  const Converter(this.objectType, {
    this.fromObject,
    this.toObject,
  });

  /// The [Type] of the predicate (subject).
  final Type objectType;

  /// The custom name for the from (subject) factory method.
  final String? fromObject;

  /// The custom name for the to (subject) method.
  final String? toObject;
}

/// {@template crow.annotation.toString}
///
/// Allows you get rid of boring [toString] overriding, Ides does the same,
/// but with this annotation hide the so long string to make your class
/// more cleaner and if you change the class property you have no worries.
///
/// To do so, annotate your class with [ToString] and override [toString] method
/// to make it point to the generated one as below.
///
/// ```dart
///
/// @ToString()
/// class User {
///   User(
///     this.firstName,
///     this.lastName,
///     this.email,
///     this.phone,
///     this.dateOfBirth,
///     this.country,
///     this.city,
///     this.postalCode,
///   );
///
///   final String firstName;
///   final String lastName;
///   final String email;
///   final String phone;
///   final DateTime dateOfBirth;
///   final String country;
///   final String city;
///   final String postalCode;
///
///   @override
///   String toString() => $toString();
/// }
/// ```
///
/// {@endtemplate}
class ToString {
  /// {@macro crow.annotation.toString}
  const ToString({
    this.includePrivets = true,
    this.exclude,
  });

  /// Exclude specific fields by passing there name.
  final List<String>? exclude;

  /// Allows privet fields to be part of [toString] result.
  final bool includePrivets;
}

/// A short hand of [ToString].
///
/// {@macro crow.annotation.toString}
const ToString toString = ToString();

/// {@template crow.annotation.equals}
///
/// Allows you get rid of boring [==] operator overriding, Ides does the same,
/// but with this annotation hide the so long overing to make your class
/// more cleaner and if you change the class property you have no worries.
///
/// ```dart
///
/// @Equals()
/// class User {
///   User(
///     this.firstName,
///     this.lastName,
///     this.email,
///     this.phone,
///     this.dateOfBirth,
///     this.country,
///     this.city,
///     this.postalCode,
///   );
///
///   final String firstName;
///   final String lastName;
///   final String email;
///   final String phone;
///   final DateTime dateOfBirth;
///   final String country;
///   final String city;
///   final String postalCode;
///
///   @override
///   bool operator ==(Object other) => $equals(other);
/// }
///
/// // Below you'll find the generated result,
/// // I don't know you, but I don't like to have that stuff in my class.
///
/// bool $equals(Object other) =>
///   identical(this, other) ||
///   other is User &&
///   runtimeType == other.runtimeType &&
///   firstName == other.firstName &&
///   lastName == other.lastName &&
///   email == other.email &&
///   phone == other.phone &&
///   dateOfBirth == other.dateOfBirth &&
///   country == other.country &&
///   city == other.city &&
///   postalCode == other.postalCode;
/// ```
/// {@endtemplate}
class Equals {
  /// {@marco crow.annotation.equals}
  const Equals({
    this.ignoreAll = false,
    this.exclude,
  });

  /// This will ignore all fields and check only if this [runtimeType] is
  /// the same as other [runtimeType].
  final bool ignoreAll;

  /// Exclude specific fields by passing there name.
  final List<String>? exclude;
}

/// {@template crow.annotation.hashCode}
///
/// Allows you get rid of boring [hashCode] operator overriding,
/// Ides does the same, but with this annotation you hide the very long overing
/// to make your class more cleaner and if you change the class property
/// you have no worries.
///
/// ```dart
/// @HashCode()
/// class User {
///   User(
///     this.firstName,
///     this.lastName,
///     this.email,
///     this.phone,
///     this.dateOfBirth,
///     this.country,
///     this.city,
///     this.postalCode,
///   );
///
///   final String firstName;
///   final String lastName;
///   final String email;
///   final String phone;
///   final DateTime dateOfBirth;
///   final String country;
///   final String city;
///   final String postalCode;
///
///   @override
///   int get hashCode => $hashCode();
/// }
///
/// // Below you'll find the generated result.
///
/// int $hashCode() =>
///   firstName.hashCode ^
///   lastName.hashCode ^
///   email.hashCode ^
///   phone.hashCode ^
///   dateOfBirth.hashCode ^
///   country.hashCode ^
///   city.hashCode ^
///   postalCode.hashCode;
///
/// ```
/// {@endtemplate}
class HashCode {
  /// {@marco crow.annotation.hashCode}
  const HashCode({this.exclude});

  /// Exclude specific fields by passing there name.
  final List<String>? exclude;
}