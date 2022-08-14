import 'package:clean_contracts/core/domain/entity.dart';

/// Model its responsible of data parsing.
abstract class Model<E extends Entity> {
  /// Convert the model to Entity.
  E toEntity();

  /// Convert the model to json object.
  Map<String, dynamic> toJson();
}
