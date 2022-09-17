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
///
/// @Converter(UserEntity)
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
///
/// Hands up, with this annotation you get out of the box the following methods:
///  - fromObject
///  - toObject
///  - fromJson
///  - toJson
///
/// ```dart
/// @Converter(User, fromObject: 'fromEntity', toObject: 'toEntity')
/// @JsonSerializable()
/// class UserModel {
///   UserModel(
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
/// }
///
/// //generated code:
///
///  static UserModel fromEntity(User user) => _$UserModelFromUser(user);
///
///   User toEntity() => _$UserModelToUser(this);
///
///   static UserModel fromJson(Map<String, dynamic> json) =>
///       _$UserModelFromJson(json);
///
///   Map<String, dynamic> toJson() => _$UserModelToJson(this);
///
/// // usage:
///
///   final Map<String, dynamic> json = model.toJson();
///   final User entity = model.toEntity();
///   final UserModel fromJson = UserModelConverter.fromJson(json);
///   final UserModel fromEntity = UserModelConverter.fromEntity(entity);
/// ```
///
/// Note: static methods fromJson/fromObject must be access by
/// `<annotated-class>Converter` extension method.
@Target(<TargetKind>{TargetKind.classType})
class Converter {
  /// Accept a [Type]
  const Converter(
    this.objectType, {
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

/// {@template crow.annotation.Super}
/// Allows you to create a normal or abstract super class,
/// this class will be named as the annotated one as a normal class
/// it can have a super class, set of mixins, interfaces
/// and even [toString], [hashCode] etc.
///
/// ```dart
/// @Super()
/// @Equals()
/// @HashCode()
/// @ToString()
/// @Immutable()
/// class UserModel extends _UserModel {
///   UserModel(
///     String super._firstName,
///     String super.lastName,
///     String super.email,
///     String super.phone,
///     DateTime super.dateOfBirth,
///     String super.country,
///     String super.city,
///     String super.postalCode,
///   );
/// }
///
/// // generated code:
///
/// // generate class is abstract by default, change [isAbstract].
///
/// abstract class _UserModel {
///   _UserModel(
///     this._firstName,
///     this.lastName,
///     this.email,
///     this.phone,
///     this.dateOfBirth,
///     this.country,
///     this.city,
///     this.postalCode,
///   );
///
/// // fields are final if class is annotated with [Immutable] of the meta package.
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
/// // following stuff are got only if class is annotated with there annotation.
/// // for the equality and hashCode they are generated only if the class is immutable.
///
///   @override
///   bool operator ==(Object other) => $equals(other);
///
///   @override
///   int get hashCode => $hashCode();
///
///   @override
///   String toString() => $toString();
/// }
///
/// ```
///
/// {@endtemplate}
@Target(<TargetKind>{TargetKind.classType})
class Super {
  /// {@macro crow.annotation.Super}
  const Super({
    this.isAbstract = true,
    this.superType,
    this.interfaces,
    this.mixins,
  });

  /// Whether this super class is an abstract.
  ///
  /// By default all generated supers are abstracts.
  final bool isAbstract;

  /// Define the super class type that the generated super will be sub off,
  /// in other words this define the super of the super.
  ///
  /// ```dart
  /// @Super(superType: Model)
  /// class UserModel extends _UserModel {}
  ///
  /// // generated code
  ///
  /// abstract class _UserModel extends Model {}
  /// ```
  final Type? superType;

  /// The sets of mixins which will be mixed in this super class.
  ///
  /// ```dart
  /// @Super(mixins: {User, Model})
  /// class UserModel extends _UserModel {}
  ///
  /// // generated code:
  ///
  /// abstract class _UserModel with User, Model {}
  /// ```
  final Set<Type>? mixins;

  /// The sets of interfaces which will be implemented by the sub class.
  final Set<Type>? interfaces;
}
