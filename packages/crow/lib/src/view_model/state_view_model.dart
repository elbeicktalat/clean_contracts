import 'package:crow/src/view_model/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// The dedicated [BaseViewModel] to deal with state of [StatefulWidget].
class StateViewModel extends BaseViewModel {
  /// Called when this object is inserted into the tree.
  ///
  /// The framework will call this method exactly once for each [State] object
  /// it creates.
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.initState()`.
  @mustCallSuper
  void initState() {}

  /// In addition to this method being invoked, it is guaranteed that the
  /// [build] method will be invoked when a reassemble is signaled. Most
  /// widgets therefore do not need to do anything in the [reassemble] method.
  @mustCallSuper
  void reassemble() {}

  /// Called when this object is removed from the tree.
  ///
  /// Subclasses should override this method to clean up any links between
  /// this object and other elements in the tree (e.g. if you have provided an
  /// ancestor with a pointer to a descendant's [RenderObject]).
  ///
  /// Implementations of this method should end with a call to the inherited
  /// method, as in `super.deactivate()`.
  @mustCallSuper
  void deactivate() {}

  /// Called when this object is reinserted into the tree after having been
  /// removed via [deactivate].
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.activate()`.
  @mustCallSuper
  void activate() {}

  /// Called when this object is removed from the tree permanently.
  ///
  /// Implementations of this method should end with a call to the inherited
  /// method, as in `super.dispose()`.
  ///
  /// See also:
  ///
  ///  * [deactivate], which is called prior to [dispose].
  @mustCallSuper
  void dispose() {}

  /// Called when a dependency of this [State] object changes.
  ///
  /// This method is also called immediately after [initState]. It is safe to
  /// call [BuildContext.dependOnInheritedWidgetOfExactType] from this method.
  @mustCallSuper
  void didChangeDependencies() {}

  /// Add additional properties associated with the node.
  ///
  /// For more info hit on:
  /// [Debug properties | Decoding Flutter](https://www.youtube.com/watch?v=DnC7eT-vh1k),
  @mustCallSuper
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {}
}
