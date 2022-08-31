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
/// @Convert(UserEntity)
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
class Convert {
  /// Accept a [Type]
  const Convert(this.objectType);

  /// The [Type] of the predicate.
  final Type objectType;
}
